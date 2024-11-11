package models;

public class SelectedProduct extends Product {

    private double selected_price;
    private int selected_tenure,prev_tenure;
    
    public SelectedProduct(Product product) {
        this.setId(product.getId());
        this.setName(product.getName());
        this.setDescription(product.getDescription());
        this.setImageUrl(product.getImageUrl());
        this.setTags(product.getTags());
        this.setCategory(product.getCategory());
        this.setSpec(product.getSpec());
        this.setLenderName(product.getLenderName());
        this.setLenderAddress(product.getLenderAddress());
        this.setPriceTenures(product.getPriceTenures());
        this.setDetails(product.getDetails());
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

}
