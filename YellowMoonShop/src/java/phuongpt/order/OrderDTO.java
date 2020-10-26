/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.order;

import java.io.Serializable;

/**
 *
 * @author PhuongPT
 */
public class OrderDTO implements Serializable {

    private String orderID;
    private String userID;
    private double total;
    private String orderDate;
    private String name;
    private String phone;
    private String address;
    private String payment;
    private String paymentStatus;

    public OrderDTO(String orderID, String userID, double total, String orderDate, String name, String phone, String address, String payment, String paymentStatus) {
        this.orderID = orderID;
        this.userID = userID;
        this.total = total;
        this.orderDate = orderDate;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.payment = payment;
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }
 
}
