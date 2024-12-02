/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Product;
import models.User;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;
import utils.DBConnect;
import utils.FetchData;

/**
 *
 * @author Srikanta
 */
public class AdminDAO {

    FetchData fd = new FetchData();

    public ResponseHandler fetchTableData(String tableName) throws SQLException {

        try {
            switch (tableName) {
                case "USER1":
                    fd.runQuery("SELECT NAME,EMAIL,PHONE_NO,ADDRESS,AGREEMENT,USERNAME FROM " + tableName);
                    break;
                default:
                    fd.runQuery("SELECT * FROM " + tableName);
                    break;
            }
            return new ResponseHandler(true, "Data fetched successfully.");

        } catch (SQLException e) {
            System.err.println("SQL Exception occurred: " + e.getMessage());
            return new ResponseHandler(false, "Failed to fetch data: " + e.getMessage());
        }
    }

    
    public int getRowCount(String tableName) throws SQLException {

        try {
            fd.runQuery("SELECT COUNT(*) FROM " + tableName);
            return fd.getRowCount();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public ResponseHandler approveProduct(int productId) throws SQLException {
        String addCategoryQuery = "UPDATE PRODUCT SET STATUS = 'APPROVED' WHERE PRODUCT_ID = ?";
        try (OracleConnection oconn = DBConnect.getConnection()) {
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(addCategoryQuery)) {
                ops.setInt(1, productId);
                int rowsInserted = ops.executeUpdate();
                if (rowsInserted > 0) {
                    return new ResponseHandler(true, "Product approved successfully !");
                } else {
                    return new ResponseHandler(false, "Failed to approve product!");
                }
            }
        }
    }

    public ResponseHandler rejectProduct(int productId) throws SQLException {
        String addCategoryQuery = "UPDATE PRODUCT SET STATUS = 'REJECTED' WHERE PRODUCT_ID = ?";
        try (OracleConnection oconn = DBConnect.getConnection()) {
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareCall(addCategoryQuery)) {
                ops.setInt(1, productId);
                int rowsInserted = ops.executeUpdate();
                if (rowsInserted > 0) {
                    return new ResponseHandler(true, "Product rejected successfully !");
                } else {
                    return new ResponseHandler(false, "Failed to reject product!");
                }
            }
        }
    }

    public ResponseHandler getAllUsers() throws SQLException {
        List<User> userList = new ArrayList<>();

        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING ALL PRODUCTS
            String fetchAllProductsQuery = "SELECT * FROM USER1";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(fetchAllProductsQuery)) {
                try (ResultSet productResult = checkStmt.executeQuery()) {
                    while (productResult.next()) {
                        User user = new User();
                        user.setName(productResult.getString("NAME"));
                        user.setEmail(productResult.getString("EMAIL"));
                        user.setPhno(productResult.getLong("PHONE_NO"));
                        user.setAddress(productResult.getString("ADDRESS"));
                        user.setAgreement(productResult.getString("AGREEMENT"));
                        user.setUsername(productResult.getString("USERNAME"));

                        //ADDING EACH PRODUCT TO PRODUCTLIST ARRAY
                        userList.add(user);
                    }
                }
            }
        }
        //checking if productList is empty
        if (!userList.isEmpty()) {
            return new ResponseHandler(true, "All Users fetched successfully!", userList);
        } else {
            return new ResponseHandler(false, "No User found!");
        }
    }
    
    
    public ResponseHandler getAllProducts() throws SQLException {
        List<Product> productList = new ArrayList<>();

        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING ALL PRODUCTS
            String fetchAllProductsQuery = "SELECT * FROM PRODUCT";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(fetchAllProductsQuery)) {
                try (ResultSet productResult = checkStmt.executeQuery()) {
                    while (productResult.next()) {
                        Product product = new Product();
                        product.setId(productResult.getInt("PRODUCT_ID"));
                        product.setName(productResult.getString("NAME"));
                        product.setPostdate(productResult.getDate("POST_DATE"));
                        product.setStatus(productResult.getString("STATUS"));
                        product.setSpec(productResult.getString("SPEC"));
                        int categoryId =productResult.getInt("Category_id");
                        int lenderId =productResult.getInt("LENDER_ID");
                        getCategoryName(categoryId, product);
                        getLenderName(lenderId, product);
                        productList.add(product);
                    }
                }
            }
        }
        
        //checking if productList is empty
        if (!productList.isEmpty()) {
            return new ResponseHandler(true, "All Products fetched successfully!", productList);
        } else {
            return new ResponseHandler(false, "No Products found!");
        }
    }
    
    public void getCategoryName(int categoryId, Product product ) throws SQLException {

       try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING ALL PRODUCTS
            String fetchCategoryName = "SELECT NAME FROM CATEGORY WHERE CATEGORY_ID=?";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(fetchCategoryName)) {
                ops.setInt(1, categoryId);
                try (ResultSet rs = ops.executeQuery()) {
                    while (rs.next()) {
                         product.setCategory(rs.getString("NAME"));
                    }
                }
            }
        }
    }
    public void getLenderName(int lenderId, Product product ) throws SQLException {

       try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING ALL PRODUCTS
            String fetchCategoryName = "SELECT NAME FROM USER1 WHERE USER_ID=?";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(fetchCategoryName)) {
                ops.setInt(1, lenderId);
                try (ResultSet rs = ops.executeQuery()) {
                    while (rs.next()) {
                         product.setLenderName(rs.getString("NAME"));
                    }
                }
            }
        }
    }
    

     
      
    
}
