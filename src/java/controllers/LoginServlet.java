package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
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

            // REGISTERING THE ORACLE DRIVER WITH THIS SERVLEt
            DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
            out.println("<h2>Step 2 : Registering oracle driver done</h2>");

            // INSTANTIATING THE ORACLE CONNECTION OBJECT
            oconn = (OracleConnection) DriverManager.getConnection("jdbc:oracle:thin:@Srikanta:1521:orcl", "MINOR", "PROJECT");
            out.println("<h2>Step 3 : Instantiating oracle connection object done</h2>");

            // CHECKING IF USER EXISTS
            String checkUserQuery = "SELECT COUNT(*) FROM USER1 WHERE EMAIL = ? OR USERNAME = ?";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(checkUserQuery)) {
                checkStmt.setString(1, emailOrUsername);
                checkStmt.setString(2, emailOrUsername);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) == 0) {
                        request.setAttribute("errorMessage", "User doesn't exist with these credentials");
                        RequestDispatcher rd = request.getRequestDispatcher("/pages/login.jsp");
                        rd.forward(request, response);
                    }
                }
            }

            // INSTANTIATING THE ORACLE PREPARED STATEMENT OBJECT
            ops = (OraclePreparedStatement) oconn.prepareCall("SELECT COUNT(*) FROM USER1 WHERE (EMAIL = ? OR USERNAME = ?) AND PASSWORD = ?");
            out.println("<h2>Step 4 : Instantiation of oracle prepared statement object done.</h2>");

            // FILLING UP THE BLANK QUERY PARAMETERS (?)
            ops.setString(1, emailOrUsername);
            ops.setString(2, emailOrUsername);
            ops.setString(3, password);
            out.println("<h2>Step 5 : Filling blank queries done.</h2>");

            // Executing the query
            try (ResultSet rs = ops.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    request.getSession().setAttribute("successMessage", "User logged in successfully!");
                    response.sendRedirect("/home");
                } else {
                    request.setAttribute("errorMessage", "Credentials didn't match! User login failed!");
                    RequestDispatcher rd = request.getRequestDispatcher("/pages/login.jsp");
                    rd.forward(request, response);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("errorMessage", ex.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/pages/login.jsp");
            rd.forward(request, response);
        } finally {
            // Ensure Oracle resources are closed properly
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
