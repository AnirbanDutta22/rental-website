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
import models.Transaction;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import responses.ResponseHandler;
import utils.DBConnect;

/**
 *
 * @author Srikanta
 */
public class TransactionDAO {
    
     public ResponseHandler getTransactions(int rentalId) throws SQLException {
        List<Transaction> transactionList = new ArrayList<>();

        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING ALL PRODUCTS
            String query = "SELECT * FROM TRANSACTION WHERE RENTAL_ID=?";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(query)) {
                checkStmt.setInt(1, rentalId);
                try (ResultSet ors = checkStmt.executeQuery()) {
                    while (ors.next()) {
                        Transaction transaction = new Transaction();
                        transaction.setRentalId(rentalId);
                        transaction.setId(ors.getInt("TRANSACTION_ID"));
                        transaction.setAmount(ors.getInt("AMOUNT"));
                        transaction.setDate(ors.getDate("TRANSACTION_DATE"));
                        transaction.setStatus(ors.getString("STATUS"));

                        transactionList.add(transaction);
                    }
                }
            }
        }
        //checking if productList is empty
        if (!transactionList.isEmpty()) {
            return new ResponseHandler(true, "All transactions fetched successfully!", transactionList);
        } else {
            return new ResponseHandler(false, "No transactions found!");
        }
    }
    
}
