package controllers;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.User;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;

public class SignupServlet extends HttpServlet {

    String name, email, password, agreement, username;

    // DECLARING ORACLE OBJECTS
    OracleConnection oconn;
    OraclePreparedStatement ops;

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
                request.getSession().setAttribute("successMessage", res.getMessage());
                response.sendRedirect("/pages/login.jsp");
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
