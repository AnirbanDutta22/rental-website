package controllers;

import dao.UserDAO;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import models.User;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;

@MultipartConfig
public class EditProfileServlet extends HttpServlet {

    String name, email, phone, address;
    long phno;

    // DECLARING ORACLE OBJECTS
    OracleConnection oconn;
    OraclePreparedStatement ops;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            name = request.getParameter("name");
            email = request.getParameter("email");
            phone = request.getParameter("phone");
            address = request.getParameter("address");
            out.println(name + " " + email + " " + phone + " " + address);
            Part avatar_image = request.getPart("avatar");
            out.println(avatar_image);

            //fetching currenr user's username
            HttpSession session = request.getSession();
            User curruser = (User) session.getAttribute("user");
            String username = curruser.getUsername();
            out.println("username" + username);

            //parsing phone number to long
            phno = Long.parseLong(phone);
            out.println(phno);

            // updating user data
            User user;

            // CHECKING IF ANY FIELD IS EMPTY
            if (email == null || email.isEmpty()) {
                email = curruser.getEmail();
            }
            if (name == null || name.isEmpty()) {
                name = curruser.getEmail();
            }
            if (phone == null || phone.isEmpty()) {
                phno = curruser.getPhno();
            }

            user = new User(name, email, phno, address, username);
            out.println(user);

            //avatar image upload
            if (avatar_image != null && avatar_image.getSize() > 0) {
                // Defining the upload path
                String uploadDir = "uploads";
                String avatarFileName = username + "_avatar" + getFileExtension(avatar_image.getSubmittedFileName());

                // Ensuring the upload directory exists
//                String uploadPath = "C:\\Users\\ratna\\OneDrive\\Documents\\Desktop\\rental-website\\web\\" + uploadDir;
                String uploadPath = getServletContext().getRealPath("") + File.separator + uploadDir;
                out.println("uploads path : " + uploadPath);
                File uploadDirectory = new File(uploadPath);
                if (!uploadDirectory.exists()) {
                    uploadDirectory.mkdir();
                }

                // Full path to save the file
                String fullPath = uploadPath + File.separator + avatarFileName;
                try {
                    avatar_image.write(fullPath);
                    out.println("File written successfully to: " + fullPath);
                } catch (IOException e) {
                    e.printStackTrace();
                    out.println("File write failed: " + e.getMessage());
                }
                out.println("Full path : " + fullPath);

                String avatarPath = uploadDir + "/" + avatarFileName;
                user.setAvatar_image(avatarPath);
                out.println("path for db : " + user.getAvatar_image());
            } else {
                user.setAvatar_image(curruser.getAvatar_image());
            }
            out.println(user.getAvatar_image());

            // USING userDAO TO update/edit USER
            UserDAO userDAO = new UserDAO();
            ResponseHandler res = userDAO.editUser(user);
            out.println("User dao");

            // GENERATING RESPONSE
            if (res.isSuccess()) {
                request.getSession().setAttribute("successMessage", res.getMessage());
                if (res.getUser() != null) {
                    // If user is found, update it in session
                    request.getSession().setAttribute("user", res.getUser());
                    response.sendRedirect("/pages/userDashboard.jsp");
                }
            } else {
                request.setAttribute("errorMessage", res.getMessage());
            }

        } catch (SQLException ex) {
            Logger.getLogger(EditProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (ops != null) {
                    ops.close();
                }
                if (oconn != null) {
                    oconn.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    // Utility method to get file extension
    private String getFileExtension(String fileName) {
        if (fileName == null) {
            return "";
        }
        int dotIndex = fileName.lastIndexOf('.');
        return (dotIndex >= 0) ? fileName.substring(dotIndex) : "";
    }
}
