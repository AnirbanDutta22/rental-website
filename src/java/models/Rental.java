/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

/**
 *
 * @author Srikanta
 */
public class Rental {
    
    private int id, requestId, productId, BorrowerId, lenderId, offeredPrice, tenure, borrowerPin, lenderPin;
    private String productName, productSpec, status, lenderName, borrowerName, borrowerAddress, borrowerDist, borrowerState, lenderAddress, lenderDist, lenderState;
    private long borrowerPhone, lenderPhone;

    public long getBorrowerPhone() {
        return borrowerPhone;
    }

    public void setBorrowerPhone(long borrowerPhone) {
        this.borrowerPhone = borrowerPhone;
    }

    public long getLenderPhone() {
        return lenderPhone;
    }

    public void setLenderPhone(long lenderPhone) {
        this.lenderPhone = lenderPhone;
    }
    
    public int getOfferedPrice() {
        return offeredPrice;
    }

    public String getBorrowerAddress() {
        return borrowerAddress;
    }

    public void setBorrowerAddress(String borrowerAddress) {
        this.borrowerAddress = borrowerAddress;
    }

    public String getBorrowerDist() {
        return borrowerDist;
    }

    public void setBorrowerDist(String borrowerDist) {
        this.borrowerDist = borrowerDist;
    }

    public String getBorrowerState() {
        return borrowerState;
    }

    public void setBorrowerState(String borrowerState) {
        this.borrowerState = borrowerState;
    }

    public int getBorrowerPin() {
        return borrowerPin;
    }

    public void setBorrowerPin(int borrowerPin) {
        this.borrowerPin = borrowerPin;
    }

    public String getLenderAddress() {
        return lenderAddress;
    }

    public void setLenderAddress(String lenderAddress) {
        this.lenderAddress = lenderAddress;
    }

    public String getLenderDist() {
        return lenderDist;
    }

    public void setLenderDist(String lenderDist) {
        this.lenderDist = lenderDist;
    }

    public String getLenderState() {
        return lenderState;
    }

    public void setLenderState(String lenderState) {
        this.lenderState = lenderState;
    }

    public int getLenderPin() {
        return lenderPin;
    }

    public void setLenderPin(int lenderPin) {
        this.lenderPin = lenderPin;
    }

    public void setOfferedPrice(int offeredPrice) {
        this.offeredPrice = offeredPrice;
    }

    public int getTenure() {
        return tenure;
    }

    public void setTenure(int tenure) {
        this.tenure = tenure;
    }

    public String getLenderName() {
        return lenderName;
    }

    public void setLenderName(String lenderName) {
        this.lenderName = lenderName;
    }

    public String getBorrowerName() {
        return borrowerName;
    }

    public void setBorrowerName(String borrowerName) {
        this.borrowerName = borrowerName;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getProductSpec() {
        return productSpec;
    }

    public void setProductSpec(String productSpec) {
        this.productSpec = productSpec;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getBorrowerId() {
        return BorrowerId;
    }

    public void setBorrowerId(int BorrowerId) {
        this.BorrowerId = BorrowerId;
    }

    public int getLenderId() {
        return lenderId;
    }

    public void setLenderId(int lenderId) {
        this.lenderId = lenderId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
    
}
