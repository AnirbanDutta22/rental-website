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
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;
import utils.DBConnect;

@WebServlet(name = "OTPVerificationServlet", urlPatterns = {"/OTPVerificationServlet"})
public class OTPVerificationServlet extends HttpServlet {

    // DECLARING ORACLE OBJECTS

    OracleConnection oconn;
    OraclePreparedStatement ops;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String digit1 = request.getParameter("digit1");
        String digit2 = request.getParameter("digit2");
        String digit3 = request.getParameter("digit3");
        String digit4 = request.getParameter("digit4");
        String enteredOtp = digit1 + digit2 + digit3 + digit4;
        HttpSession session = request.getSession();
        String sessionOtp = (String) session.getAttribute("otp");
        String username = (String) session.getAttribute("username");

        if (sessionOtp != null && sessionOtp.equals(enteredOtp)) {
            try {
                oconn = DBConnect.getConnection();

                String updateQuery = "UPDATE USER1 SET ISVERIFIED = 'TRUE' WHERE username = ?";
                ops = (OraclePreparedStatement) oconn.prepareStatement(updateQuery);

                // Set the username parameter
                ops.setString(1, username);

                // Execute the update
                int rowsUpdated = ops.executeUpdate();

                if (rowsUpdated > 0) {
                    response.getWriter().println("User verification updated successfully.");
                } else {
                    response.getWriter().println("No matching user found for update.");
                }

            } catch (SQLException ex) {
                Logger.getLogger(OTPVerificationServlet.class.getName()).log(Level.SEVERE, null, ex);
                response.getWriter().println("An error occurred while updating user verification: " + ex.getMessage());
            } finally {
                try {
                    // Close resources
                    if (ops != null) {
                        ops.close();
                    }
                    if (oconn != null) {
                        oconn.close();
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(OTPVerificationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            // Redirect user with a success message
            session.removeAttribute("successMessage");
            session.setAttribute("signupSuccessMessage", "Registered Successfully!");
            response.sendRedirect("/pages/login.jsp");
        } else {
            // Handle OTP mismatch
            session.setAttribute("otpErrorMessage", "Invalid OTP! Please try again!");
            response.sendRedirect("/pages/signup.jsp");
        }
    }
}