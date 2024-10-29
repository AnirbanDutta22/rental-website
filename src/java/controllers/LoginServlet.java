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
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;

public class LoginServlet extends HttpServlet {

    String password, emailOrUsername;

    // DECLARING ORACLE OBJECTS
    OracleConnection oconn;
    OraclePreparedStatement ops;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            //FETCHING VALUES FROM LOGIN FORM
            emailOrUsername = request.getParameter("username");
            out.println(emailOrUsername);
            password = request.getParameter("password");
            out.println(password);

            // CHECKING IF ANY FIELD IS EMPTY
            if (emailOrUsername == null || emailOrUsername.isEmpty()
                    || password == null || password.isEmpty()) {
                request.setAttribute("errorMessage", "All Fields are required");
                RequestDispatcher rd = request.getRequestDispatcher("/pages/login.jsp");
                rd.forward(request, response);
            }

            // USING SignupDAO TO ADD USER
            UserDAO loginDAO = new UserDAO();
            ResponseHandler res = loginDAO.loginUser(emailOrUsername, password);

            // GENERATING RESPONSE
            if (res.isSuccess()) {
                request.getSession().setAttribute("successMessage", res.getMessage());
                if (res.getUser() != null) {
                    // If user is found, store it in session
                    request.getSession().setAttribute("user", res.getUser()); // Store entire User object
                    response.sendRedirect("/home");
                }
            } else {
                request.setAttribute("errorMessage", res.getMessage());
                RequestDispatcher rd = request.getRequestDispatcher("/pages/login.jsp");
                rd.forward(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("errorMessage", ex.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/pages/login.jsp");
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
