/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

/**
 *
 * @author Srikanta
 */

import dao.UserDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import responses.ResponseHandler;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/ResetPasswordServlet"})
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (password == null || confirmPassword == null || !password.equals(confirmPassword)) {
            session.setAttribute("errorMessage", "Passwords do not match.");
            response.sendRedirect("/pages/forgetPassword.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");
        if (email == null) {
            session.setAttribute("errorMessage", "Session expired. Please restart the process.");
            response.sendRedirect("/pages/forgetPassword.jsp");
            return;
        }

        UserDAO userDao = new UserDAO();
        try {
            ResponseHandler res = userDao.updatePassword(email, password);
            if (res.isSuccess()) {
                session.invalidate();
                session = request.getSession(true);
                session.setAttribute("successMessage", "Password updated successfully!");
                response.sendRedirect("/pages/login.jsp");
            } else {
                session.setAttribute("errorMessage", res.getMessage());
                response.sendRedirect("/pages/forgetPassword.jsp");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ResetPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
            session.setAttribute("errorMessage", "Database error occurred.");
            response.sendRedirect("/pages/forgetPassword.jsp");
        }
    }
}
