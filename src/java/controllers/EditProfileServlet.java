package controllers;

import dao.UserDAO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import models.User;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;

@WebServlet(name = "EditProfileServlet", urlPatterns = {"/EditProfileServlet"})
@MultipartConfig
public class EditProfileServlet extends HttpServlet {

    String name, email, phone, address, district, state, pinString;
    int pin;
    long phno;
    boolean isVerified;

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
            district = request.getParameter("district");
            state = request.getParameter("state");
            pinString = request.getParameter("pin");
            out.println(name + " " + email + " " + phone + " " + address + " " + district + " " + state + " " + pinString);
            Part avatar_image = request.getPart("avatar");
            Part cover_image = request.getPart("cover");
            out.println(avatar_image);
            out.println(cover_image);

            //fetching currenr user's username
            HttpSession session = request.getSession();
            User curruser = (User) session.getAttribute("user");
            String username = curruser.getUsername();
            int id = curruser.getId();
            out.println("username" + username);

            //parsing phone number to long
            phno = Long.parseLong(phone);
            out.println(phno);
            //parsing pin to int
            pin = Integer.parseInt(pinString);
            out.println(pin);
            
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
            
            //CHECKING IF ADDRESS, DISTRICT, STATE, PIN IS EMPTY OR NOT
            isVerified = !(address.isEmpty() || address == null || district.isEmpty() || district == null || state.isEmpty() || state == null || pinString.isEmpty() || pinString == null);
            out.println(isVerified);
            // updating user data
            User user;
            user = new User(id, name, email, phno, address, district, state, pin,isVerified, username);
            out.println(user);

            //avatar image upload
            if ((avatar_image != null && avatar_image.getSize() > 0) || (cover_image != null && cover_image.getSize() > 0)) {
                // Defining the upload path
                String uploadDir = "uploads";
                String avatarFileName = username + "_avatar" + getFileExtension(avatar_image.getSubmittedFileName());
                String coverFileName = username + "_cover" + getFileExtension(cover_image.getSubmittedFileName());

                // Ensuring the upload directory exists
                String uploadPath = getServletContext().getRealPath("") + File.separator + uploadDir;
                out.println("uploads path : " + uploadPath);
                File uploadDirectory = new File(uploadPath);
                if (!uploadDirectory.exists()) {
                    uploadDirectory.mkdir();
                }

                // Full path to save the file
                String fullAvatarPath = uploadPath + File.separator + avatarFileName;
                String fullCoverPath = uploadPath + File.separator + coverFileName;
                try {
                    avatar_image.write(fullAvatarPath);
                    out.println("File written successfully to: " + fullAvatarPath);
                    cover_image.write(fullCoverPath);
                    out.println("File written successfully to: " + fullCoverPath);
                } catch (IOException e) {
                    e.printStackTrace();
                    out.println("File write failed: " + e.getMessage());
                }
                out.println("Full cover path : " + fullCoverPath + "Full avatar path : " + fullAvatarPath);

                String avatarPath = uploadDir + "/" + avatarFileName;
                String coverPath = uploadDir + "/" + coverFileName;
                user.setAvatar_image(avatarPath);
                user.setCover_image(coverPath);
                out.println("path for db : " + user.getAvatar_image() + " and " + user.getCover_image());
            } else {
                user.setAvatar_image(curruser.getAvatar_image());
                user.setCover_image(curruser.getCover_image());
            }
            out.println(user.getAvatar_image());
            out.println(user.getCover_image());

            // USING userDAO TO update/edit USER
            UserDAO userDAO = new UserDAO();
            ResponseHandler res = userDAO.editUser(user);
            out.println("User dao");

            // GENERATING RESPONSE
            if (res.isSuccess()) {
                request.getSession().setAttribute("successMessage", res.getMessage());
                if (res.getData() != null) {
                    // If user is found, update it in session
                    request.getSession().setAttribute("user", res.getData());
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
