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

    public Transaction getTransaction(int rentalId, int transactionId) throws SQLException {
        Transaction tran = new Transaction();
        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR FETCHING TRANSACTION
            String query = "SELECT * FROM TRANSACTION WHERE RENTAL_ID=? AND TRANSACTION_ID=?";
            try (OraclePreparedStatement checkStmt = (OraclePreparedStatement) oconn.prepareStatement(query)) {
                checkStmt.setInt(1, rentalId);
                checkStmt.setInt(2, transactionId);
                try (ResultSet transactionResult = checkStmt.executeQuery()) {
                    while (transactionResult.next()) {
                        tran.setRentalId(transactionResult.getInt("RENTAL_ID"));
                        tran.setId(transactionResult.getInt("TRANSACTION_ID"));
                        tran.setAmount(transactionResult.getInt("AMOUNT"));
                    }
                }
            }
            return tran;
        }
    }
    
     public ResponseHandler setTransactionStatusPaid(int rentalId,int transactionId) throws SQLException {
        try (OracleConnection oconn = DBConnect.getConnection()) {

            //QUERY FOR setting the rent payment status 'completed'
            String query = "UPDATE TRANSACTION SET status='completed' WHERE RENTAL_ID=? AND TRANSACTION_ID=?";
            try (OraclePreparedStatement setTransaction = (OraclePreparedStatement) oconn.prepareStatement(query)) {
                setTransaction.setInt(1, rentalId);
                setTransaction.setInt(2, transactionId);
                int rowsInserted = setTransaction.executeUpdate();
                if (rowsInserted > 0) {
                    return new ResponseHandler(true, "Transaction status updated !!");
                } else {
                    return new ResponseHandler(false, "Transaction status updatation failed !!");
                }
            }
        }
    }
}
