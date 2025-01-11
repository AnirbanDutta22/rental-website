/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlers;

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

        if (sessionOtp != null && sessionOtp.equals(enteredOtp)) {
            response.getWriter().println("OTP Verified Successfully!");
            session.removeAttribute("successMessage");
            session.setAttribute("signupSuccessMessage","Registered Successfully !");
            response.sendRedirect("/pages/login.jsp");
        } else {
            session.setAttribute("otpErrorMessage","Invalid OTP ! Please try again !");
            response.sendRedirect("/pages/signup.jsp");
        }
    }
}
