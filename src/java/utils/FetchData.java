/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.sql.SQLException;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import oracle.jdbc.OracleResultSet;
import oracle.jdbc.OracleResultSetMetaData;

/**
 *
 * @author Srikanta
 */
public class FetchData {

    OracleConnection oconn;
    OraclePreparedStatement ops;
    OracleResultSet ors;
    OracleResultSetMetaData orsmd;
    int rowCount;
    String query;

    public void runQuery(String query) throws SQLException {
        try {
            oconn = DBConnect.getConnection();
            ops = (OraclePreparedStatement) oconn.prepareStatement(query);
            ors = (OracleResultSet) ops.executeQuery();
            orsmd = (OracleResultSetMetaData) ors.getMetaData();
        } catch (Exception e) {
            throw new SQLException("Error executing query: " + e.getMessage());
        }
    }

    public int getRowCount() throws SQLException {
        try {
            if (ors.next()) {
                rowCount = ors.getInt(1); // Store the row count in rowCount variable
            }
        } catch (Exception e) {
            throw new SQLException("Error executing query: " + e.getMessage());
        }
        return rowCount;
    }

    public OracleResultSetMetaData getMetaData() {
        return orsmd;
    }

    public OracleResultSet getResultSet() {
        return ors;
    }
     public void closeConnections() throws SQLException {
        if (ors != null) ors.close();
        if (ops != null) ops.close();
        if (oconn != null) oconn.close();
    }
}
