/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models.product;

public class Product {
    private String name;
    private double price;
    private String imageUrl;
    

    // Constructor
    public Product(String name, double price,String imageUrl) {
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
    }

    // Getter for name
    public String getName() {
        return name;
    }

    // Getter for price
    public double getPrice() {
        return price;
    }
    
    // Getter for imgURL
    public String getImageUrl() {
        return imageUrl;
    }
}
