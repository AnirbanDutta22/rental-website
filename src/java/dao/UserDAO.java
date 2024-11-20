package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import models.Product;
import models.Product.Details;
import models.Product.PriceTenure;
import models.SelectedProduct;
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
            String query = "INSERT INTO USER1 (USER_ID, NAME, EMAIL, PASSWORD, AGREEMENT, USERNAME) VALUES (user_id_sequence.NEXTVAL, ?, ?, ?, ?, ?)";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(query)) {
                ops.setString(1, user.getName());
                ops.setString(2, user.getEmail());
                ops.setString(3, user.getPassword());
                ops.setString(4, user.getAgreement());
                ops.setString(5, user.getUsername());

                int rowsInserted = ops.executeUpdate(); // executeUpdate function
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
                                    user.setId(rs2.getInt("USER_ID"));
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
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(cancelRequestQuery)) {
                ops.setInt(1, request_id);
                ops.setInt(2, product_id);

                int rowsDeleted = ops.executeUpdate();
                if (rowsDeleted > 0) {
                    return new ResponseHandler(true, "Request accepted successfully !");
                } else {
                    return new ResponseHandler(false, "Request accept failed !");
                }
            }
        }
    }

    //add product
    public ResponseHandler addProduct(Product product, int userId) throws SQLException {

        try (OracleConnection oconn = DBConnect.getConnection()) {
            // Get the next sequence value
            String getNextIdQuery = "SELECT id_sequence.NEXTVAL AS PRODUCT_ID FROM DUAL";
            OraclePreparedStatement seqStmt = (OraclePreparedStatement) oconn.prepareStatement(getNextIdQuery);
            ResultSet seqRs = seqStmt.executeQuery();

            int productId = 121;
            if (seqRs.next()) {
                productId = seqRs.getInt("PRODUCT_ID");
            } else {
                return new ResponseHandler(false, "Failed to generate Product ID");
            }

            //Insert at product table
            String insertProducrQuery = "INSERT INTO PRODUCT(PRODUCT_ID, NAME, DESCRIPTION, SPEC, CATEGORY_ID, LENDER_ID) VALUES (?,?, ?, ?, ?,?)";

            OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(insertProducrQuery);
            ops.setInt(1, productId);
            ops.setString(2, product.getName());
            ops.setString(3, product.getDescription());
            ops.setString(4, product.getSpec());
            ops.setInt(5, product.getCategoryId());
            ops.setInt(6, userId);

            int rowsInserted = ops.executeUpdate();
            if (rowsInserted <= 0) {
                return new ResponseHandler(false, "Failed to add Product");
            }

            // Insert Images
            for (String imageUrl : product.getImageUrl()) {
                String insertProductImageQuery = "INSERT INTO PRODUCT_IMAGE(PRODUCT_IMAGE_ID, PRODUCT_ID, IMAGE) VALUES (id_sequence.NEXTVAL, ?, ?)";
                OraclePreparedStatement insertImageOPS = (OraclePreparedStatement) oconn.prepareStatement(insertProductImageQuery);
                insertImageOPS.setInt(1, productId);
                insertImageOPS.setString(2, imageUrl);

                int imageRows = insertImageOPS.executeUpdate();
                if (imageRows <= 0) {
                    return new ResponseHandler(false, "Failed to add Image. Insertion terminated");
                }
            }

            // Insert Tags
            for (String tag : product.getTags()) {
                String insertProductTagQuery = "INSERT INTO PRODUCT_TAGS(PRODUCT_TAG_ID, PRODUCT_ID, TAG) VALUES (id_sequence.NEXTVAL, ?, ?)";
                OraclePreparedStatement insertTagOPS = (OraclePreparedStatement) oconn.prepareStatement(insertProductTagQuery);
                insertTagOPS.setInt(1, productId);
                insertTagOPS.setString(2, tag);

                int tagRows = insertTagOPS.executeUpdate();
                if (tagRows <= 0) {
                    return new ResponseHandler(false, "Failed to add Tags. Insertion terminated");
                }
            }

            // Insert Price and Tenure
            for (PriceTenure priceTenure : product.getPriceTenures()) {
                String insertProductPriceQuery = "INSERT INTO PRODUCT_PRICE(PRODUCT_PRICE_ID, PRODUCT_ID, PRICE, TENURE) VALUES (id_sequence.NEXTVAL, ?, ?, ?)";
                OraclePreparedStatement insertPriceOPS = (OraclePreparedStatement) oconn.prepareStatement(insertProductPriceQuery);
                insertPriceOPS.setInt(1, productId);
                insertPriceOPS.setDouble(2, priceTenure.getPrice());
                insertPriceOPS.setInt(3, priceTenure.getTenure());

                int priceRows = insertPriceOPS.executeUpdate();
                if (priceRows <= 0) {
                    return new ResponseHandler(false, "Failed to add Price and Tenure. Insertion terminated");
                }
            }

            // Insert Title and Details for more details
            for (Details details : product.getDetails()) {
                String insertProductPriceQuery = "INSERT INTO PRODUCT_DETAILS(PRODUCT_DETAILS_ID, PRODUCT_ID, TITLE, DETAILS) VALUES (id_sequence.NEXTVAL, ?, ?, ?)";
                OraclePreparedStatement insertDetailsOPS = (OraclePreparedStatement) oconn.prepareStatement(insertProductPriceQuery);
                insertDetailsOPS.setInt(1, productId);
                insertDetailsOPS.setString(2, details.getTitle());
                insertDetailsOPS.setString(3, details.getDetails());

                int priceRows = insertDetailsOPS.executeUpdate();
                if (priceRows <= 0) {
                    return new ResponseHandler(false, "Failed to add Title and Details. Insertion terminated");
                }
            }

            return new ResponseHandler(true, "Product successfully added");
        } catch (SQLException e) {
            e.printStackTrace();
            return new ResponseHandler(false, "Database Error: " + e.getMessage());
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
}
