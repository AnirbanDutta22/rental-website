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

public class SignupServlet extends HttpServlet {

    String name, phno, email, password, agreement, username;
    long phone_no;

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
            phno = request.getParameter("phno");
            password = request.getParameter("password");
            agreement = request.getParameter("agreement");

            // CHECKING IF ANY FIELD IS EMPTY
            if (email == null || email.isEmpty()
                    || name == null || name.isEmpty()
                    || phno == null || phno.isEmpty()
                    || password == null || password.isEmpty()
                    || agreement == null || agreement.isEmpty()) {
                request.setAttribute("errorMessage", "All Fields are required");
                RequestDispatcher rd = request.getRequestDispatcher("/pages/signup.jsp");
                rd.forward(request, response);
                return;
            }

            // PARSING PHONE NUMBER TO LONG FORMAT AND GENERATING USERNAME
            phone_no = Long.parseLong(phno);
            out.println(phone_no);
            username = email.replace(".com", "rentle");
            out.println(username);

            // REGISTERING THE ORACLE DRIVER WITH THIS SERVLEt
            DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
            out.println("<h2>Step 2 : Registering oracle driver done</h2>");

            // INSTANTIATING THE ORACLE CONNECTION OBJECT
            oconn = (OracleConnection) DriverManager.getConnection("jdbc:oracle:thin:@Srikanta:1521:orcl", "MINOR", "PROJECT");
            out.println("<h2>Step 3 : Instantiating oracle connection object done</h2>");

            // CHECKING IF USER ALREADY EXISTS
            String checkUserQuery = "SELECT COUNT(*) FROM USER1 WHERE EMAIL = ? OR PHONE_NO = ? OR USERNAME = ?";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(checkUserQuery)) {
                checkStmt.setString(1, email);
                checkStmt.setLong(2, phone_no);
                checkStmt.setString(3, username);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        request.setAttribute("errorMessage", "User already exists with these credentials");
                        RequestDispatcher rd = request.getRequestDispatcher("/pages/signup.jsp");
                        rd.forward(request, response);
                        return;
                    }
                }
            }

            // INSTANTIATING THE ORACLE PREPARED STATEMENT OBJECT
            ops = (OraclePreparedStatement) oconn.prepareCall("INSERT INTO USER1(USER_ID,NAME,EMAIL,PHONE_NO,PASSWORD,AGREEMENT,USERNAME) values(?,?,?,?,?,?,?)");
            out.println("<h2>Step 4 : Instantiation of oracle prepared statement object done.</h2>");

            // FILLING UP THE BLANK QUERY PARAMETERS (?)
            ops.setInt(1, 6);
            ops.setString(2, name);
            ops.setString(3, email);
            ops.setLong(4, phone_no);
            ops.setString(5, password);
            ops.setString(6, agreement);
            ops.setString(7, username);
            out.println("<h2>Step 5 : Filling blank queries done.</h2>");

            // EXECUTING THE QUERY
            int x = ops.executeUpdate();

            if (x > 0) {
                // CLOSING THE ORACLE OBJECTS
                ops.close();
                oconn.close();
                request.getSession().setAttribute("successMessage", "User registration done successfully!");
                response.sendRedirect("/pages/login.jsp");

            } else {
                // CLOSING THE ORACLE OBJECTS
                ops.close();
                oconn.close();
                request.setAttribute("errorMessage", "User registration failed !");
                RequestDispatcher rd = request.getRequestDispatcher("/pages/signup.jsp");
                rd.forward(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("errorMessage", ex.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/pages/signup.jsp");
            rd.forward(request, response);
        }
    }
}
