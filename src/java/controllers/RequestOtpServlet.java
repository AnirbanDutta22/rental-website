package controllers;

import dao.UserDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import responses.ResponseHandler;

@WebServlet(name = "RequestOtpServlet", urlPatterns = {"/RequestOtpServlet"})
public class RequestOtpServlet extends HttpServlet {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_USER = "bcaminor2025@gmail.com";
    private static final String EMAIL_PASS = "qivhmjlxvzrjktgw";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = request.getParameter("email");

        if (email == null || email.isEmpty()) {
            session.setAttribute("errorMessage", "Email is required");
            response.sendRedirect("/pages/forgetPassword.jsp");
            return;
        }

        UserDAO userDao = new UserDAO();
        try {
            ResponseHandler res = userDao.checkUserExistance(email);
            if (res.isSuccess()) {
                String otp = String.valueOf((int) (Math.random() * 9000) + 1000);
                session.setAttribute("email", email);
                session.setAttribute("otp", otp);

                sendOtpEmail(email, otp);
                session.setAttribute("successMessage", "OTP sent to your email!");
                response.sendRedirect("/pages/forgetPassword.jsp");
            } else {
                session.setAttribute("errorMessage", res.getMessage());
                response.sendRedirect("/pages/forgetPassword.jsp");
            }
        } catch (SQLException | MessagingException ex) {
            Logger.getLogger(RequestOtpServlet.class.getName()).log(Level.SEVERE, null, ex);
            session.setAttribute("errorMessage", "An error occurred. Try again.");
            response.sendRedirect("/pages/forgetPassword.jsp");
        }
    }

    private void sendOtpEmail(String recipientEmail, String otp) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session mailSession = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_USER, EMAIL_PASS);
            }
        });

        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(EMAIL_USER));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject("OTP Verification");
        message.setText("Your OTP code is: " + otp);

        Transport.send(message);
    }
}
