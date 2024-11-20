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
import models.Category;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;
import utils.DBConnect;

/**
 *
 * @author Srikanta
 */
public class CategoryDAO {
    
    
    
     public ResponseHandler getCategory() throws SQLException {
        List<Category> categoryList = new ArrayList<>();

        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING ALL CATEGORY
            String fetchAllcategoryQuery = "SELECT * FROM CATEGORY";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(fetchAllcategoryQuery)) {
                try (ResultSet categoryResult = checkStmt.executeQuery()) {
                    while (categoryResult.next()) {
                        Category category = new Category();
                        category.setId(categoryResult.getInt("CATEGORY_ID"));
                        category.setName(categoryResult.getString("NAME"));
                       
                        //ADDING EACH PRODUCT TO PRODUCTLIST ARRAY
                        categoryList.add(category);
                    }
                }
            }
        }
        //checking if productList is empty
        if (!categoryList.isEmpty()) {
            return new ResponseHandler(true, "All Category fetched successfully!", categoryList);
        } else {
            return new ResponseHandler(false, "No Category found!");
        }
    }
    
}
