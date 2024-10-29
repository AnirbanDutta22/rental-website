package utils;

import java.sql.DriverManager;
import java.sql.SQLException;
import oracle.jdbc.OracleConnection;

public class DBConnect {

    private static final String URL = "jdbc:oracle:thin:@Ami-Anirban:1522:orcl";
    private static final String USER = "MINOR";
    private static final String PASSWORD = "PROJECT";

    OracleConnection oconn;

    static {
        try {
            DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
        } catch (SQLException ex) {
            throw new ExceptionInInitializerError("Failed to load Oracle JDBC driver.");
        }
    }

    public static OracleConnection getConnection() throws SQLException {
        return (OracleConnection) DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Optional: A method to close the connection
    public static void closeConnection(OracleConnection oconn) {
        if (oconn != null) {
            try {
                oconn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
