package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import models.User;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;
import utils.DBConnect;

public class UserDAO {

    //method for user signup
    public ResponseHandler signupUser(User user) throws SQLException {

        try (OracleConnection oconn = DBConnect.getConnection()) {
            // CHECKING IF USER ALREADY EXISTS
            String checkUserQuery = "SELECT COUNT(*) FROM USER1 WHERE EMAIL = ?";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(checkUserQuery)) {
                checkStmt.setString(1, user.getEmail());
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        return new ResponseHandler(false, "User with these credentials already exists !");
                    }
                }
            }

            // INSERTING USER DATA TO DATABASE
            String query = "INSERT INTO USER1 (USER_ID, NAME, EMAIL, PASSWORD, AGREEMENT, USERNAME) VALUES (?, ?, ?, ?, ?, ?)";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(query)) {
                ops.setInt(1, 15);
                ops.setString(2, user.getName());
                ops.setString(3, user.getEmail());
                ops.setString(4, user.getPassword());
                ops.setString(5, user.getAgreement());
                ops.setString(6, user.getUsername());

                int rowsInserted = ops.executeUpdate();
                if (rowsInserted > 0) {
                    return new ResponseHandler(true, "Signup Successfull !");
                } else {
                    return new ResponseHandler(false, "Signup failed ! Try again !");
                }
            }
        }
    }
    
    //method for user login
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
                                    user.setAvatar_image(rs2.getString("AVATAR_IMAGE"));

                                    return new ResponseHandler(true, "Logged in successfully", user);
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

    //method for user profile edit/update
    public ResponseHandler editUser(User user) throws SQLException {
        try (OracleConnection oconn = DBConnect.getConnection()) {
            String checkUserQuery;
            checkUserQuery = "UPDATE USER1 SET NAME = ?, EMAIL = ?, PHONE_NO = ?, ADDRESS = ?, AVATAR_IMAGE = ? WHERE USERNAME = ?";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(checkUserQuery)) {
                ops.setString(1, user.getName());
                ops.setString(2, user.getEmail());
                ops.setLong(3, user.getPhno());
                ops.setString(4, user.getAddress());

                ops.setString(5, user.getAvatar_image());
                ops.setString(6, user.getUsername());

                // Execute update
                int rowsUpdated = ops.executeUpdate();
                if (rowsUpdated > 0) {
                    return new ResponseHandler(true, "User data updated successfully!", user);
                } else {
                    return new ResponseHandler(false, "User data updatation failed!");
                }
            }
        }
    }
}
