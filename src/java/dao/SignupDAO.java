package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import models.User;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;
import utils.DBConnect;

public class SignupDAO {

    public ResponseHandler signupUser(User user) throws SQLException {

        try (OracleConnection oconn = DBConnect.getConnection()) {
            // CHECKING IF USER ALREADY EXISTS
            String checkUserQuery = "SELECT COUNT(*) FROM USER1 WHERE EMAIL = ? OR PHONE_NO = ? OR USERNAME = ?";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(checkUserQuery)) {
                checkStmt.setString(1, user.getEmail());
                checkStmt.setLong(2, user.getPhno());
                checkStmt.setString(3, user.getUsername());
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        return new ResponseHandler(false, "User with these credentials already exists !");
                    }
                }
            }

            // INSERTING USER DATA TO DATABASE
            String query = "INSERT INTO USER1 (USER_ID, NAME, EMAIL, PHONE_NO, PASSWORD, AGREEMENT, USERNAME) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(query)) {
                ops.setInt(1, 20);
                ops.setString(2, user.getName());
                ops.setString(3, user.getEmail());
                ops.setLong(4, user.getPhno());
                ops.setString(5, user.getPassword());
                ops.setString(6, user.getAgreement());
                ops.setString(7, user.getUsername());

                int rowsInserted = ops.executeUpdate();
                if (rowsInserted > 0) {
                    return new ResponseHandler(true, "Signup Successfull !");
                } else {
                    return new ResponseHandler(false, "Signup failed ! Try again !");
                }
            }
        }
    }
}
