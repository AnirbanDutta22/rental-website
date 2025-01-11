package controllers;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.User;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.*;

@WebServlet(name = "SignupServlet", urlPatterns = {"/SignupServlet"})
public class SignupServlet extends HttpServlet {

    String name, email, password, agreement, username;

    // DECLARING ORACLE OBJECTS
    OracleConnection oconn;
    OraclePreparedStatement ops;

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_USER = "bcaminor2025@gmail.com";
    private static final String EMAIL_PASS = "qivhmjlxvzrjktgw";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            //FETCHING VALUES FROM SIGNUP FORM
            email = request.getParameter("email");
            name = request.getParameter("name");
            password = request.getParameter("password");
            agreement = request.getParameter("agreement");

            // CHECKING IF ANY FIELD IS EMPTY
            if (email == null || email.isEmpty()
                    || name == null || name.isEmpty()
                    || password == null || password.isEmpty()
                    || agreement == null || agreement.isEmpty()) {
                request.setAttribute("errorMessage", "All Fields are required");
                RequestDispatcher rd = request.getRequestDispatcher("/pages/signup.jsp");
                rd.forward(request, response);
                return;
            }

            // GENERATING USERNAME
            username = email.replace(".com", "rentle");
            out.println(username);

            // CREATING USER OBJECT WITH SIGNUP DATA
            User user = new User(name, email, password, agreement, username);

            // USING UserDAO TO signup USER
            UserDAO signupDAO = new UserDAO();
            ResponseHandler res = signupDAO.signupUser(user);

            // GENERATING RESPONSE
            if (res.isSuccess()) {
                //generate otp
//                String recipient = request.getParameter("email");
                String otp = String.valueOf((int) (Math.random() * 9000) + 1000);

                // Save OTP in session
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                try {
                    // Set SMTP properties
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

                    // Compose message
                    Message message = new MimeMessage(mailSession);
                    message.setFrom(new InternetAddress(EMAIL_USER));
                    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                    message.setSubject("Otp Verification");
                    message.setText("Your OTP code is: " + otp);

                    // Send email
                    Transport.send(message);

//                    response.sendRedirect("verifyOTP.jsp");
                    request.getSession().setAttribute("successMessage", "OTP sent to your email !");
                    response.sendRedirect("/pages/signup.jsp");
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().println("Failed to send OTP. Please try again.");
                }
            } else {
                request.setAttribute("errorMessage", res.getMessage());
                RequestDispatcher rd = request.getRequestDispatcher("/pages/signup.jsp");
                rd.forward(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("errorMessage", ex.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/pages/signup.jsp");
            rd.forward(request, response);
        } finally {

            // Ensuring Oracle resources are closed properly
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
