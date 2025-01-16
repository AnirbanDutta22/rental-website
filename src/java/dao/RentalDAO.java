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
import models.Rental;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;
import utils.DBConnect;

/**
 *
 * @author Srikanta
 */
public class RentalDAO {

    public Rental getRentalProduct(int requestId) throws SQLException {

        Rental rental = new Rental();
        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING ALL PRODUCTS
            String query = "SELECT * FROM RENTAL_REQUEST WHERE STATUS='accepted' AND REQUEST_ID=?";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(query)) {
                checkStmt.setInt(1, requestId);
                try (ResultSet rentalResult = checkStmt.executeQuery()) {
                    while (rentalResult.next()) {
                        rental.setRequestId(rentalResult.getInt("REQUEST_ID"));
                        rental.setProductId(rentalResult.getInt("PRODUCT_ID"));
                        rental.setBorrowerId(rentalResult.getInt("BORROWER_ID"));
                        rental.setLenderId(rentalResult.getInt("LENDER_ID"));
                        rental.setOfferedPrice(rentalResult.getInt("OFFERED_PRICE"));
                        rental.setTenure(rentalResult.getInt("TENURE"));
                        
                        // fetch additional details
                        getBorrowerDetails(rental.getBorrowerId(), rental);
                        getLenderDetails(rental.getLenderId(), rental);
                        getProductName(rental.getProductId(), rental);
                        getRental(rental.getRequestId(), rental);

                    }
                }
            }
        }
        //checking if productList is empty
//        if (rental.isEmpty()) {
//            return new ResponseHandler(true, "All Users fetched successfully!", rental);
//        } else {
//            return new ResponseHandler(false, "No User found!");
//        }
        return rental;
    }

    public ResponseHandler getRentalDetails(int userId) throws SQLException {
        List<Rental> rentalList = new ArrayList<>();

        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING ALL PRODUCTS
            String query = "SELECT * FROM RENTAL_REQUEST WHERE STATUS='accepted' AND (BORROWER_ID=? OR LENDER_ID=?)";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(query)) {
                checkStmt.setInt(1, userId);
                checkStmt.setInt(2, userId);
                try (ResultSet rentalResult = checkStmt.executeQuery()) {
                    while (rentalResult.next()) {
                        Rental rental = new Rental();
                        rental.setRequestId(rentalResult.getInt("REQUEST_ID"));
                        rental.setProductId(rentalResult.getInt("PRODUCT_ID"));
                        rental.setBorrowerId(rentalResult.getInt("BORROWER_ID"));
                        rental.setLenderId(rentalResult.getInt("LENDER_ID"));

                        getRental(rental.getRequestId(), rental);
                        getProductName(rental.getProductId(), rental);

                        rentalList.add(rental);
                    }
                }
            }
        }
        //checking if productList is empty
        if (!rentalList.isEmpty()) {
            System.out.print(rentalList);
            rentalList.stream().forEach((rental1) -> {
            });
            return new ResponseHandler(true, "Rental details fetched successfully!", rentalList);
        } else {
            return new ResponseHandler(false, "No details found!");
        }
    }

    public void getProductName(int productId, Rental rental) throws SQLException {

        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING ALL PRODUCTS
            String fetchCategoryName = "SELECT NAME, SPEC FROM PRODUCT WHERE PRODUCT_ID=?";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(fetchCategoryName)) {
                ops.setInt(1, productId);
                try (ResultSet rs = ops.executeQuery()) {
                    while (rs.next()) {
                        rental.setProductName(rs.getString("NAME"));
                        rental.setProductSpec(rs.getString("SPEC"));
                    }
                }
            }
        }
    }

    public void getRental(int requestId, Rental rental) throws SQLException {

        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING ALL PRODUCTS
            String fetchCategoryName = "SELECT RENTAL_ID, STATUS FROM RENTAL WHERE REQUEST_ID=?";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(fetchCategoryName)) {
                ops.setInt(1, requestId);
                try (ResultSet rs = ops.executeQuery()) {
                    while (rs.next()) {
                        rental.setId(rs.getInt("RENTAL_ID"));
                        rental.setStatus(rs.getString("STATUS"));
                    }
                }
            }
        }
    }

    public void getBorrowerDetails(int borrowerId, Rental rental) throws SQLException {

        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING ALL PRODUCTS
            String query = "SELECT NAME, PHONE_NO, ADDRESS, DISTRICT, STATE, PIN FROM USER1 WHERE USER_ID=?";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(query)) {
                ops.setInt(1, borrowerId);
                try (ResultSet rs = ops.executeQuery()) {
                    while (rs.next()) {
                        rental.setBorrowerName(rs.getString("NAME"));
                        rental.setBorrowerPhone(rs.getLong("PHONE_NO"));
                        rental.setBorrowerAddress(rs.getString("ADDRESS"));
                        rental.setBorrowerDist(rs.getString("DISTRICT"));
                        rental.setBorrowerState(rs.getString("STATE"));
                        rental.setBorrowerPin(rs.getInt("PIN"));
                    }
                }
            }
        }
    }

    public void getLenderDetails(int lenderId, Rental rental) throws SQLException {

        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING ALL PRODUCTS
            String query = "SELECT NAME, PHONE_NO, ADDRESS, DISTRICT, STATE, PIN FROM USER1 WHERE USER_ID=?";
            try (OraclePreparedStatement ops = (OraclePreparedStatement) oconn.prepareStatement(query)) {
                ops.setInt(1, lenderId);
                try (ResultSet rs = ops.executeQuery()) {
                    while (rs.next()) {
                        rental.setLenderName(rs.getString("NAME"));
                        rental.setLenderPhone(rs.getLong("PHONE_NO"));
                        rental.setLenderAddress(rs.getString("ADDRESS"));
                        rental.setLenderDist(rs.getString("DISTRICT"));
                        rental.setLenderState(rs.getString("STATE"));
                        rental.setLenderPin(rs.getInt("PIN"));
                    }
                }
            }
        }
    }

}
