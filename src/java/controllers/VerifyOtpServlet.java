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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "VerifyOtpServlet", urlPatterns = {"/VerifyOtpServlet"})
public class VerifyOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String digit1 = request.getParameter("digit1");
        String digit2 = request.getParameter("digit2");
        String digit3 = request.getParameter("digit3");
        String digit4 = request.getParameter("digit4");

        if (digit1 == null || digit2 == null || digit3 == null || digit4 == null) {
            session.setAttribute("errorMessage", "Please enter a valid OTP.");
            response.sendRedirect("/pages/forgetPassword.jsp");
            return;
        }

        String enteredOtp = digit1 + digit2 + digit3 + digit4;
        String sessionOtp = (String) session.getAttribute("otp");

        if (sessionOtp != null && sessionOtp.equals(enteredOtp)) {
            session.setAttribute("otpVerified", true);
            session.removeAttribute("successMessage");
            session.setAttribute("successOTPMessage", "OTP verified successfully!");
            response.sendRedirect("/pages/forgetPassword.jsp");
        } else {
            session.setAttribute("errorMessage", "Invalid OTP. Try again.");
            response.sendRedirect("/pages/forgetPassword.jsp");
        }
    }
}

