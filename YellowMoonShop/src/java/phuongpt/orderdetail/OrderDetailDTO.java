/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.orderdetail;

import java.io.Serializable;

/**
 *
 * @author PhuongPT
 */
public class OrderDetailDTO implements Serializable {

    private String detailID;
    private String orderID;
    private String product;
    private double price;
    private int quantity;

    public OrderDetailDTO(String detailID, String orderID, String product, double price, int quantity) {
        this.detailID = detailID;
        this.orderID = orderID;
        this.product = product;
        this.price = price;
        this.quantity = quantity;
    }

    public String getDetailID() {
        return detailID;
    }

    public void setDetailID(String detailID) {
        this.detailID = detailID;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
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
