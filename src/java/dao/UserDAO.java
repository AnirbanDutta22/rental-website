package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import models.User;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;
import utils.DBConnect;

public class UserDAO {

    public ResponseHandler loginUser(String emailOrUsername, String password) throws SQLException {
        try (OracleConnection oconn = DBConnect.getConnection()) {
            // CHECKING IF USER EXISTS
            String checkUserQuery = "SELECT COUNT(*) FROM USER1 WHERE EMAIL = ? OR USERNAME = ?";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(checkUserQuery)) {
                checkStmt.setString(1, emailOrUsername);
                checkStmt.setString(2, emailOrUsername);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        // IF USER EXISTS THEN CHECK PASSWORD IS CORRECT OR NOT
                        String query = "SELECT * FROM USER1 WHERE (EMAIL = ? OR USERNAME = ?) AND PASSWORD = ?";
                        try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(query)) {
                            ops.setString(1, emailOrUsername);
                            ops.setString(2, emailOrUsername);
                            ops.setString(3, password);
                            try (ResultSet rs2 = ops.executeQuery()) {
                                if (rs2.next()) {
                                    User user = new User();
                                    user.setName(rs2.getString("NAME"));
                                    user.setEmail(rs2.getString("EMAIL"));
                                    user.setPhno(rs2.getLong("PHONE_NO"));
                                    user.setAddress(rs2.getString("ADDRESS"));
                                    user.setUsername(rs2.getString("USERNAME"));
                                    
                                    return new ResponseHandler(true, "Logged in successfully",user);
                                } else {
                                    return new ResponseHandler(false, "Invalid password !");
                                }
                            }
                        }
                    } else {
                        return new ResponseHandler(false, "User doesn't exist !");
                    }
                }
            }
        }
    }
}
