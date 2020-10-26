/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.payment;

import java.io.Serializable;

/**
 *
 * @author PhuongPT
 */
public class PaymentDTO implements Serializable {
    private String paymentID, name;

    public PaymentDTO(String paymentID, String name) {
        this.paymentID = paymentID;
        this.name = name;
    }

    public String getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(String paymentID) {
        this.paymentID = paymentID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    
}
