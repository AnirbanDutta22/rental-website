package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import models.Product;
import models.Product.Details;
import models.Product.PriceTenure;
import models.SelectedProduct;
import models.User;
import models.OtherProfile;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;
import utils.DBConnect;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

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
            String query = "INSERT INTO USER1 (USER_ID, NAME, EMAIL, PASSWORD, AGREEMENT, USERNAME) VALUES (user_id_sequence.NEXTVAL, ?, ?, ?, ?, ?)";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(query)) {
                ops.setString(1, user.getName());
                ops.setString(2, user.getEmail());
                ops.setString(3, user.getPassword());
                ops.setString(4, user.getAgreement());
                ops.setString(5, user.getUsername());

                int rowsInserted = ops.executeUpdate(); // executeUpdate function
                if (rowsInserted > 0) {
                    return new ResponseHandler(true, "Signup Successfull !!");
                } else {
                    return new ResponseHandler(false, "Signup failed ! Try again !");
                }
            }
        }
    }

    //method for user forget password
    public ResponseHandler checkUserExistance(String email) throws SQLException {

        try (OracleConnection oconn = DBConnect.getConnection()) {
            // CHECKING IF USER EXISTS OR NOT
            String checkUserQuery = "SELECT COUNT(*) FROM USER1 WHERE EMAIL = ?";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(checkUserQuery)) {
                checkStmt.setString(1, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) < 1) {
                        return new ResponseHandler(false, "User does not exists !");
                    } else {
                        return new ResponseHandler(true, "email exists !!");
                    }
                }
            }
        }
    }

    public ResponseHandler updatePassword(String email, String password) throws SQLException {

        // UPDATING PASSWORD
        try (OracleConnection oconn = DBConnect.getConnection()) {
            String query = " UPDATE USER1 SET PASSWORD = ? WHERE EMAIL = ?";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(query)) {
                ops.setString(1, password);
                ops.setString(2, email);

                int rowsInserted = ops.executeUpdate(); // executeUpdate function
                if (rowsInserted > 0) {
                    return new ResponseHandler(true, "Password updated !!");
                } else {
                    return new ResponseHandler(false, "Failed ! Try again !");
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
                                    user.setId(rs2.getInt("USER_ID"));
                                    user.setEmail(rs2.getString("EMAIL"));
                                    user.setPhno(rs2.getLong("PHONE_NO"));
                                    user.setAddress(rs2.getString("ADDRESS"));
                                    user.setDistrict(rs2.getString("DISTRICT"));
                                    user.setState(rs2.getString("STATE"));
                                    user.setPin(rs2.getInt("PIN"));
                                    user.setUsername(rs2.getString("USERNAME"));
                                    user.setAvatar_image(rs2.getString("AVATAR_IMAGE"));
                                    user.setCover_image(rs2.getString("COVER_IMAGE"));
                                    if (rs2.getString("ISVERIFIED").trim().equals("TRUE")) {
                                        user.setIsVerified(true);
                                    } else {
                                        user.setIsVerified(false);
                                    }

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
            checkUserQuery = "UPDATE USER1 SET NAME = ?, EMAIL = ?, PHONE_NO = ?, ADDRESS = ?,DISTRICT = ?,STATE = ?,PIN = ?, AVATAR_IMAGE = ?, COVER_IMAGE = ?,isVerified = ? WHERE USER_ID = ?";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(checkUserQuery)) {
                ops.setString(1, user.getName());
                ops.setString(2, user.getEmail());
                ops.setLong(3, user.getPhno());
                ops.setString(4, user.getAddress());
                ops.setString(5, user.getDistrict());
                ops.setString(6, user.getState());
                ops.setInt(7, user.getPin());
                ops.setString(8, user.getAvatar_image());
                ops.setString(9, user.getCover_image());
                if (user.isIsVerified()) {
                    ops.setString(10, "TRUE");
                } else {
                    ops.setString(10, "FALSE");
                }
                ops.setInt(11, user.getId());

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

    //method for adding product to wishlist
    public ResponseHandler addToWishlist(int product_id, int user_id) throws SQLException {
        String addToWishlistQuery = "INSERT INTO USER_WISHLIST (WISHLIST_ID,PRODUCT_ID,USER_ID) VALUES (id_sequence.NEXTVAL,?,?)";
        try (OracleConnection oconn = DBConnect.getConnection()) {
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(addToWishlistQuery)) {
                ops.setInt(1, product_id);
                ops.setInt(2, user_id);

                int rowsInserted = ops.executeUpdate();
                if (rowsInserted > 0) {
                    return new ResponseHandler(true, "Product added to wishlist successfully !");
                } else {
                    return new ResponseHandler(false, "Product add to wishlist failed !");
                }
            }
        }
    }

    //method for removing product from wishlist
    public ResponseHandler removeFromWishlist(int product_id, int user_id) throws SQLException {
        String addToWishlistQuery = "DELETE FROM USER_WISHLIST WHERE PRODUCT_ID = ? AND USER_ID = ?";
        try (OracleConnection oconn = DBConnect.getConnection()) {
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(addToWishlistQuery)) {
                ops.setInt(1, product_id);
                ops.setInt(2, user_id);

                int rowsDeleted = ops.executeUpdate();
                if (rowsDeleted > 0) {
                    return new ResponseHandler(true, "Product removed from wishlist successfully !");
                } else {
                    return new ResponseHandler(false, "Product remove failed !");
                }
            }
        }
    }

    //method for sending borrow request
    public ResponseHandler sendBorrowRequest(SelectedProduct selectedProduct, User user) throws SQLException {
        int lenderId;
        String getLenderId = "SELECT USER_ID FROM USER1 WHERE USERNAME=?";
        try (OracleConnection oconn = DBConnect.getConnection()) {
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(getLenderId)) {
                ops.setString(1, selectedProduct.getProduct().getLenderUsername());

                ResultSet rs = ops.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    lenderId = rs.getInt("USER_ID");
                } else {
                    return new ResponseHandler(false, "Lender ID not found !");
                }
            }
        }
        String sendRequestQuery = "INSERT INTO RENTAL_REQUEST (REQUEST_ID,LENDER_ID,BORROWER_ID,PRODUCT_ID,PRODUCT_PRICE,TENURE,OFFERED_PRICE,MESSAGE,STATUS) VALUES (id_sequence.NEXTVAL,?,?,?,?,?,?,?,?)";
        try (OracleConnection oconn = DBConnect.getConnection()) {
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(sendRequestQuery)) {
                ops.setInt(1, lenderId);
                ops.setInt(2, user.getId());
                ops.setInt(3, selectedProduct.getProduct().getId());
                ops.setDouble(4, selectedProduct.getSelectedPrice());
                ops.setInt(5, selectedProduct.getSelectedTenure());
                ops.setDouble(6, selectedProduct.getOfferedPrice());
                ops.setString(7, selectedProduct.getMessage());
                ops.setString(8, "pending");

                int rowsInserted = ops.executeUpdate();
                if (rowsInserted > 0) {
                    return new ResponseHandler(true, "Request sent successfully !");
                } else {
                    return new ResponseHandler(false, "Request send failed !");
                }
            }
        }
    }

    //method for cancelling borrow request
    public ResponseHandler cancelBorrowRequest(int product_id, int request_id) throws SQLException {
        String cancelRequestQuery = "DELETE FROM RENTAL_REQUEST WHERE REQUEST_ID=? AND PRODUCT_ID=?";
        try (OracleConnection oconn = DBConnect.getConnection()) {
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(cancelRequestQuery)) {
                ops.setInt(1, request_id);
                ops.setInt(2, product_id);

                int rowsDeleted = ops.executeUpdate();
                if (rowsDeleted > 0) {
                    return new ResponseHandler(true, "Request cancelled successfully !");
                } else {
                    return new ResponseHandler(false, "Request cancellation failed !");
                }
            }
        }
    }

    //method for rejecting borrow request
    public ResponseHandler rejectBorrowRequest(int product_id, int request_id) throws SQLException {
        String cancelRequestQuery = "UPDATE RENTAL_REQUEST SET STATUS = 'rejected' WHERE REQUEST_ID=? AND PRODUCT_ID=?";
        try (OracleConnection oconn = DBConnect.getConnection()) {
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(cancelRequestQuery)) {
                ops.setInt(1, request_id);
                ops.setInt(2, product_id);

                int rowsDeleted = ops.executeUpdate();
                if (rowsDeleted > 0) {
                    return new ResponseHandler(true, "Request rejected successfully !");
                } else {
                    return new ResponseHandler(false, "Request rejection failed !");
                }
            }
        }
    }

    //method for accepting borrow request
    public ResponseHandler acceptBorrowRequest(int product_id, int request_id) throws SQLException {
        String cancelRequestQuery = "UPDATE RENTAL_REQUEST SET STATUS = 'accepted', REQUEST_DATE = SYSDATE WHERE REQUEST_ID=? AND PRODUCT_ID=?";
        try (OracleConnection oconn = DBConnect.getConnection()) {
            OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(cancelRequestQuery);
            ops.setInt(1, request_id);
            ops.setInt(2, product_id);

            int rowsUpdated = ops.executeUpdate();
            if (rowsUpdated <= 0) {
                return new ResponseHandler(false, "Request accept failed!");
            }

            // Fetch product_price and tenure
            String fetchDetailsQuery = "SELECT PRODUCT_PRICE, TENURE FROM RENTAL_REQUEST WHERE REQUEST_ID = ? AND PRODUCT_ID = ?";
            try (OraclePreparedStatement fetchDetailsStmt = (OraclePreparedStatement) oconn.prepareStatement(fetchDetailsQuery)) {
                fetchDetailsStmt.setInt(1, request_id);
                fetchDetailsStmt.setInt(2, product_id);

                ResultSet detailsRs = fetchDetailsStmt.executeQuery();
                if (!detailsRs.next()) {
                    return new ResponseHandler(false, "Product price or tenure not found!");
                }

                double productPrice = detailsRs.getDouble("PRODUCT_PRICE");
                int tenure = detailsRs.getInt("TENURE");

                // Calculate the installment amount
                double installmentAmount = productPrice;

                // Get the next sequence value for Rental ID
                String getNextIdQuery = "SELECT id_sequence.NEXTVAL AS RENTAL_ID FROM DUAL";
                OraclePreparedStatement seqStmt = (OraclePreparedStatement) oconn.prepareStatement(getNextIdQuery);
                ResultSet seqRs = seqStmt.executeQuery();

                int rentalId = 1;
                if (seqRs.next()) {
                    rentalId = seqRs.getInt("RENTAL_ID");
                } else {
                    return new ResponseHandler(false, "Failed to generate Rental ID");
                }

                // Rental start date and end date based on tenure
                LocalDateTime currentDateTime = LocalDateTime.now(ZoneId.systemDefault());
                LocalDateTime tenureEndDateTime = currentDateTime.plusMonths(tenure);

                Timestamp sqlCurrentTimestamp = Timestamp.valueOf(currentDateTime);
                Timestamp sqlTenureEndTimestamp = Timestamp.valueOf(tenureEndDateTime);

                String addRentalQuery = "INSERT INTO RENTAL (RENTAL_ID, REQUEST_ID, STATUS, START_DATE, END_DATE) VALUES (?, ?, 'pending', ?, ?)";
                try (OraclePreparedStatement addRentalOPS = (OraclePreparedStatement) oconn.prepareStatement(addRentalQuery)) {
                    addRentalOPS.setInt(1, rentalId);
                    addRentalOPS.setInt(2, request_id);
                    addRentalOPS.setTimestamp(3, sqlCurrentTimestamp);
                    addRentalOPS.setTimestamp(4, sqlTenureEndTimestamp);

                    int rowsInserted = addRentalOPS.executeUpdate();
                    if (rowsInserted <= 0) {
                        return new ResponseHandler(false, "Insertion at Rental failed!");
                    }
                }

                // Insert transaction data for each installment
                for (int i = 1; i <= tenure; i++) {
                    // Get the next sequence value for Transaction ID
                    String getNextTransactionIdQuery = "SELECT id_sequence.NEXTVAL AS TRANSACTION_ID FROM DUAL";
                    seqStmt = (OraclePreparedStatement) oconn.prepareStatement(getNextTransactionIdQuery);
                    ResultSet seqTransaction = seqStmt.executeQuery();

                    int transactionId = 1;
                    if (seqTransaction.next()) {
                        transactionId = seqTransaction.getInt("TRANSACTION_ID");
                    } else {
                        return new ResponseHandler(false, "Failed to generate Transaction ID");
                    }

                    // Calculate the transaction date for the installment
                    LocalDateTime transactionDateTime = currentDateTime.plusMonths(i);
                    Timestamp sqlTransactionTimestamp = Timestamp.valueOf(transactionDateTime);

                    String addTransactionQuery = "INSERT INTO TRANSACTION (TRANSACTION_ID, RENTAL_ID, AMOUNT, TRANSACTION_DATE, STATUS) VALUES (?, ?, ?, ?, 'pending')";
                    try (OraclePreparedStatement addTransactionOPS = (OraclePreparedStatement) oconn.prepareStatement(addTransactionQuery)) {
                        addTransactionOPS.setInt(1, transactionId);
                        addTransactionOPS.setInt(2, rentalId);
                        addTransactionOPS.setDouble(3, installmentAmount);
                        addTransactionOPS.setTimestamp(4, sqlTransactionTimestamp);

                        int rowsInserted = addTransactionOPS.executeUpdate();
                        if (rowsInserted <= 0) {
                            return new ResponseHandler(false, "Insertion at Transaction failed!");
                        }
                    }
                }

                return new ResponseHandler(true, "Request accepted successfully!", rentalId);
            }
        }
    }

    //add product
    public ResponseHandler addProduct(Product product, int userId) throws SQLException {
        try (OracleConnection oconn = DBConnect.getConnection()) {
            // Disable auto-commit to manually control transactions
            oconn.setAutoCommit(false);

            // Get the next sequence value
            String getNextIdQuery = "SELECT id_sequence.NEXTVAL AS PRODUCT_ID FROM DUAL";
            try (OraclePreparedStatement seqStmt = (OraclePreparedStatement) oconn.prepareStatement(getNextIdQuery)) {
                ResultSet seqRs = seqStmt.executeQuery();
                int productId;
                if (seqRs.next()) {
                    productId = seqRs.getInt("PRODUCT_ID");
                } else {
                    return new ResponseHandler(false, "Failed to generate Product ID");
                }

                // Insert into PRODUCT table
                String insertProductQuery = "INSERT INTO PRODUCT(PRODUCT_ID, NAME, DESCRIPTION, SPEC, CATEGORY_ID, LENDER_ID) VALUES (?,?,?,?,?,?)";
                try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(insertProductQuery)) {
                    ops.setInt(1, productId);
                    ops.setString(2, product.getName());
                    ops.setString(3, product.getDescription());
                    ops.setString(4, product.getSpec());
                    ops.setInt(5, product.getCategoryId());
                    ops.setInt(6, userId);

                    int rowsInserted = ops.executeUpdate();
                    if (rowsInserted <= 0) {
                        oconn.rollback();
                        return new ResponseHandler(false, "Failed to add Product");
                    }
                }

                // Insert Images
                for (String imageUrl : product.getImageUrl()) {
                    String insertProductImageQuery = "INSERT INTO PRODUCT_IMAGE(PRODUCT_IMAGE_ID, PRODUCT_ID, IMAGE) VALUES (id_sequence.NEXTVAL, ?, ?)";
                    try (OraclePreparedStatement insertImageOPS = (OraclePreparedStatement) oconn.prepareStatement(insertProductImageQuery)) {
                        insertImageOPS.setInt(1, productId);
                        insertImageOPS.setString(2, imageUrl);

                        int imageRows = insertImageOPS.executeUpdate();
                        if (imageRows <= 0) {
                            oconn.rollback();
                            return new ResponseHandler(false, "Failed to add Image. Insertion terminated");
                        }
                    }
                }

                // Insert Tags
                for (String tag : product.getTags()) {
                    String insertProductTagQuery = "INSERT INTO PRODUCT_TAGS(PRODUCT_TAG_ID, PRODUCT_ID, TAG) VALUES (id_sequence.NEXTVAL, ?, ?)";
                    try (OraclePreparedStatement insertTagOPS = (OraclePreparedStatement) oconn.prepareStatement(insertProductTagQuery)) {
                        insertTagOPS.setInt(1, productId);
                        insertTagOPS.setString(2, tag);

                        int tagRows = insertTagOPS.executeUpdate();
                        if (tagRows <= 0) {
                            oconn.rollback();
                            return new ResponseHandler(false, "Failed to add Tags. Insertion terminated");
                        }
                    }
                }

                // Insert Price and Tenure
                for (PriceTenure priceTenure : product.getPriceTenures()) {
                    String insertProductPriceQuery = "INSERT INTO PRODUCT_PRICE(PRODUCT_PRICE_ID, PRODUCT_ID, PRICE, TENURE) VALUES (id_sequence.NEXTVAL, ?, ?, ?)";
                    try (OraclePreparedStatement insertPriceOPS = (OraclePreparedStatement) oconn.prepareStatement(insertProductPriceQuery)) {
                        insertPriceOPS.setInt(1, productId);
                        insertPriceOPS.setDouble(2, priceTenure.getPrice());
                        insertPriceOPS.setInt(3, priceTenure.getTenure());

                        int priceRows = insertPriceOPS.executeUpdate();
                        if (priceRows <= 0) {
                            oconn.rollback();
                            return new ResponseHandler(false, "Failed to add Price and Tenure. Insertion terminated");
                        }
                    }
                }

                // Insert Title and Details
                for (Details details : product.getDetails()) {
                    String insertProductDetailsQuery = "INSERT INTO PRODUCT_DETAILS(PRODUCT_DETAILS_ID, PRODUCT_ID, TITLE, DETAILS) VALUES (id_sequence.NEXTVAL, ?, ?, ?)";
                    try (OraclePreparedStatement insertDetailsOPS = (OraclePreparedStatement) oconn.prepareStatement(insertProductDetailsQuery)) {
                        insertDetailsOPS.setInt(1, productId);
                        insertDetailsOPS.setString(2, details.getTitle());
                        insertDetailsOPS.setString(3, details.getDetails());

                        int detailsRows = insertDetailsOPS.executeUpdate();
                        if (detailsRows <= 0) {
                            oconn.rollback();
                            return new ResponseHandler(false, "Failed to add Title and Details. Insertion terminated");
                        }
                    }
                }

                // Commit the transaction
                oconn.commit();
                return new ResponseHandler(true, "Product successfully added");

            } catch (SQLException e) {
                // Rollback the transaction in case of an exception
                oconn.rollback();
                e.printStackTrace();
                return new ResponseHandler(false, "Database Error: " + e.getMessage());
            } finally {
                // Restore auto-commit mode
                oconn.setAutoCommit(true);
            }
        }
    }

    //remove product
    public ResponseHandler removeProduct(int productId, String username) throws SQLException {

        try (OracleConnection oconn = DBConnect.getConnection()) {

            //Checking if user id and product id matches
            String findProductQuery = "SELECT * FROM PRODUCT WHERE PRODUCT_ID=? AND LENDER_ID=(SELECT USER_ID FROM USER1 WHERE USERNAME = ?)";
            OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(findProductQuery);
            ops.setInt(1, productId);
            ops.setString(2, username);

            ResultSet productFound = ops.executeQuery();
            if (productFound.next()) {
                int userId = productFound.getInt("LENDER_ID");
                int rowsDeleted;

                //check if the product exists in rental table
                String checkExistenceInRental = "SELECT * FROM RENTAL WHERE REQUEST_ID = (SELECT REQUEST_ID FROM RENTAL_REQUEST WHERE PRODUCT_ID=?)";
                OraclePreparedStatement checkProduct = (OraclePreparedStatement) oconn.prepareStatement(checkExistenceInRental);
                checkProduct.setInt(1, productId);

                ResultSet productFoundInRental = checkProduct.executeQuery();
                if (productFoundInRental.next()) {
                    return new ResponseHandler(false, "Product remove failed! Exist on Rental!");
                }

                //remove record from product details table
                String removeProductDetailsQuery = "DELETE FROM PRODUCT_DETAILS WHERE PRODUCT_ID=?";
                OraclePreparedStatement deleteProductDetails = (OraclePreparedStatement) oconn.prepareStatement(removeProductDetailsQuery);
                deleteProductDetails.setInt(1, productId);

                rowsDeleted = deleteProductDetails.executeUpdate();
                if (rowsDeleted <= 0) {
                    return new ResponseHandler(false, "Product details remove failed !");
                }

                //remove records from product image table
                String removeProductImagesQuery = "DELETE FROM PRODUCT_IMAGE WHERE PRODUCT_ID=?";
                OraclePreparedStatement deleteProductImages = (OraclePreparedStatement) oconn.prepareStatement(removeProductImagesQuery);
                deleteProductImages.setInt(1, productId);

                rowsDeleted = deleteProductImages.executeUpdate();
                if (rowsDeleted <= 0) {
                    return new ResponseHandler(false, "Product images remove failed !");
                }

                //remove records from product price table
                String removeProductPricesQuery = "DELETE FROM PRODUCT_PRICE WHERE PRODUCT_ID=?";
                OraclePreparedStatement deleteProductPrices = (OraclePreparedStatement) oconn.prepareStatement(removeProductPricesQuery);
                deleteProductPrices.setInt(1, productId);

                rowsDeleted = deleteProductPrices.executeUpdate();
                if (rowsDeleted <= 0) {
                    return new ResponseHandler(false, "Product prices remove failed !");
                }

                //remove records from product tags table
                String removeProductTagsQuery = "DELETE FROM PRODUCT_TAGS WHERE PRODUCT_ID=?";
                OraclePreparedStatement deleteProductTags = (OraclePreparedStatement) oconn.prepareStatement(removeProductTagsQuery);
                deleteProductTags.setInt(1, productId);

                rowsDeleted = deleteProductTags.executeUpdate();
                if (rowsDeleted <= 0) {
                    return new ResponseHandler(false, "Product prices remove failed !");
                }

                //remove record from request table
                String removeProductFromRequestQuery = "DELETE FROM RENTAL_REQUEST WHERE PRODUCT_ID=? AND LENDER_ID=?";
                OraclePreparedStatement deleteProductFromRequest = (OraclePreparedStatement) oconn.prepareStatement(removeProductFromRequestQuery);
                deleteProductFromRequest.setInt(1, productId);
                deleteProductFromRequest.setInt(2, userId);

                rowsDeleted = deleteProductFromRequest.executeUpdate();
                if (rowsDeleted <= 0) {
                    return new ResponseHandler(false, "Product remove from request failed !");
                }

                //remove record from product table
                String removeProductQuery = "DELETE FROM PRODUCT WHERE PRODUCT_ID=? AND LENDER_ID=?";
                OraclePreparedStatement deleteProduct = (OraclePreparedStatement) oconn.prepareStatement(removeProductQuery);
                deleteProduct.setInt(1, productId);
                deleteProduct.setInt(2, userId);

                rowsDeleted = deleteProduct.executeUpdate();
                if (rowsDeleted <= 0) {
                    return new ResponseHandler(false, "Product remove failed !");
                }

                return new ResponseHandler(true, "Product removed successfully !");
            } else {
                return new ResponseHandler(false, "Product and User ID didn't matched");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseHandler(false, "Database Error: " + e.getMessage());
        }

    }

    //get lender details and products
    public OtherProfile getLenderDetails(String lenderId) throws SQLException {
        OtherProfile otherProfile = null;
        try (OracleConnection oconn = DBConnect.getConnection()) {
            // CHECKING IF USER EXISTS
            String checkUserQuery = "SELECT U.*, P.PRODUCT_ID, P.NAME AS PRODUCT_NAME, P.SPEC, P.STATUS AS PRODUCT_STATUS, P.POST_DATE FROM USER1 U LEFT JOIN PRODUCT P ON U.USER_ID = P.LENDER_ID WHERE U.USERNAME = ?;";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(checkUserQuery)) {
                checkStmt.setString(1, lenderId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    List<Product> products = new ArrayList<>(); // List to store product details
                    boolean userDetailsSet = false;

                    while (rs.next()) {
                        if (!userDetailsSet) { // Set user details only once
                            otherProfile.setName(rs.getString("NAME"));
                            otherProfile.setUsername(rs.getString("USERNAME"));
                            otherProfile.setAddress(rs.getString("ADDRESS"));
                            otherProfile.setDistrict(rs.getString("DISTRICT"));
                            otherProfile.setState(rs.getString("STATE"));
                            otherProfile.setAvatar_image(rs.getString("AVATAR_IMAGE"));
                            otherProfile.setCover_image(rs.getString("COVER_IMAGE"));
                            userDetailsSet = true; // Ensure user details are not set repeatedly
                        }

                        // Create and populate a Product object for each product
                        Product product = new Product();
                        product.setId(rs.getInt("PRODUCT_ID"));
                        product.setName(rs.getString("PRODUCT_NAME"));
                        product.setSpec(rs.getString("SPEC"));
                        product.setPostdate(rs.getDate("POST_DATE"));

                        // Add the product to the list
                        products.add(product);
                    }

                    // Attach the product list to the otherProfile or handle as needed
                    otherProfile.setProductList(products);
                }
            }

        }
        return otherProfile;
    }
}
