/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.List;

public class Product {
    private int id;
    private String name;
    private String description;
    private String[] imageUrl;
    private String[] tags;
    private String category;
    private String spec;
    private String lenderName;
    private String lenderAddress;
    
    // List of price and tenure combinations
    private List<PriceTenure> priceTenures;

    // List of additional details (title and description)
    private List<Details> details;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    
    // Constructor
    public Product(){
        
    }
    public Product(String name, String description,String category, String[] imageUrl,List<PriceTenure> priceTenures,List<Details> details) {
        this.name = name;
        this.description = description;
        this.category = category;
        this.imageUrl = imageUrl;
        this.priceTenures = priceTenures;
        this.details = details;
    }

    public String getDescription() {
        return description;
    }

    public String getCategory() {
        return category;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setImageUrl(String[] imageUrl) {
        this.imageUrl = imageUrl;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSpec() {
        return spec;
    }

    public void setSpec(String spec) {
        this.spec = spec;
    }
    
    public String[] getTags() {
        return tags;
    }

    public void setTags(String[] tags) {
        this.tags = tags;
    }
    
    public String getName() {
        return name;
    }
    
    public String[] getImageUrl() {
        return imageUrl;
    }

    public List<PriceTenure> getPriceTenures() {
        return priceTenures;
    }

    public void setPriceTenures(List<PriceTenure> priceTenures) {
        this.priceTenures = priceTenures;
    }

    public List<Details> getDetails() {
        return details;
    }

    public void setDetails(List<Details> details) {
        this.details = details;
    }
    
    public String getLenderName() {
        return lenderName;
    }

    public void setLenderName(String lenderName) {
        this.lenderName = lenderName;
    }

    public String getLenderAddress() {
        return lenderAddress;
    }

    public void setLenderAddress(String lenderAddress) {
        this.lenderAddress = lenderAddress;
    }
    
    // PriceTenure Model
    public static class PriceTenure {
        private double price;
        private int tenure;

        public PriceTenure(double price, int tenure) {
            this.price = price;
            this.tenure = tenure;
        }

        public double getPrice() {
            return price;
        }

        public void setPrice(double price) {
            this.price = price;
        }

        public int getTenure() {
            return tenure;
        }

        public void setTenure(int tenure) {
            this.tenure = tenure;
        }
    }

    // Details Model
    public static class Details {
        private String title;
        private String details;

        public Details(String title, String details) {
            this.title = title;
            this.details = details;
        }

        public String getTitle() {
            return title;
        }

        public String getDetails() {
            return details;
        }

        public void setDetails(String details) {
            this.details = details;
        }

        public void setTitle(String title) {
            this.title = title;
        }
    }
}