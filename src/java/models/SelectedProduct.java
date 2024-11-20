package models;

import java.util.Date;

public class SelectedProduct {

    private double selected_price, offered_price;
    private int selected_tenure,prev_tenure,requestId;

    private String status,message;
    private Date date;
    
    private Product product;
    private User user;
    
    public SelectedProduct(){
        
    }
    
    public SelectedProduct(Product product) {
        this.product = product;
    }
    
    public SelectedProduct(Product product,User user) {
        this.product = product;
        this.user = user;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public double getOfferedPrice() {
        return offered_price;
    }

    public void setOfferedPrice(double offered_price) {
        this.offered_price = offered_price;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public double getSelectedPrice() {
        return selected_price;
    }

    public void setSelectedPrice(double selected_price) {
        this.selected_price = selected_price;
    }

    public int getSelectedTenure() {
        return selected_tenure;
    }

    public void setSelectedTenure(int selected_tenure) {
        this.selected_tenure = selected_tenure;
    }
    
    public int getPrevTenure() {
        return prev_tenure;
    }

    public void setPrevTenure(int prev_tenure) {
        this.prev_tenure = prev_tenure;
    }
    
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }
}
