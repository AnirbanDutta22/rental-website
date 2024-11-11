package controllers;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.User;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;

public class RemoveWishlistServlet extends HttpServlet {

    int user_id,product_id;

    // DECLARING ORACLE OBJECTS
    OracleConnection oconn;
    OraclePreparedStatement ops;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            product_id = Integer.parseInt(request.getParameter("productId"));
            out.println(product_id);

            //fetching currenr user's username
            HttpSession session = request.getSession();
            User curruser = (User) session.getAttribute("user");
            if (curruser == null) {
                response.sendRedirect("/pages/login.jsp");
            } else {
                user_id = curruser.getId();
                out.println(user_id);
            }

            // USING userDAO TO REMOVE PRODUCT FROM WISHLIST
            UserDAO userDAO = new UserDAO();
            ResponseHandler res = userDAO.removeFromWishlist(product_id, user_id);
            out.println("User DAO");

            // GENERATING RESPONSE
            if (res.isSuccess()) {
                request.getSession().setAttribute("successMessage", res.getMessage());
                response.sendRedirect("/pages/wishlist.jsp");
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
}
