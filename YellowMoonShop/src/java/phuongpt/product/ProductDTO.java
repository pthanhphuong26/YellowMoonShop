/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.product;

import java.io.Serializable;

/**
 *
 * @author PhuongPT
 */
public class ProductDTO implements Serializable {
    private String proID, name, image, description,
            creationDate, expirationDate, category, status;
    private double price;
    private int quantity;

    public ProductDTO(String proID, String name, String image, String description, String creationDate, String expirationDate, String category, String status, double price, int quantity) {
        this.proID = proID;
        this.name = name;
        this.image = image;
        this.description = description;
        this.creationDate = creationDate;
        this.expirationDate = expirationDate;
        this.category = category;
        this.status = status;
        this.price = price;
        this.quantity = quantity;
    }

    public String getProID() {
        return proID;
    }

    public void setProID(String proID) {
        this.proID = proID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
    }

    public String getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(String expirationDate) {
        this.expirationDate = expirationDate;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    
}
