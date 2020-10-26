/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.payment;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import phuongpt.util.DBHelper;

/**
 *
 * @author PhuongPT
 */
public class PaymentDAO implements Serializable {
    private List<PaymentDTO> listPayments;

    public List<PaymentDTO> getListPayments() {
        return listPayments;
    }

    public void findAllPayments() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT paymentID, name FROM tblPayment";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String paymentID = rs.getString("paymentID");
                    String name = rs.getString("name");
                    PaymentDTO dto = new PaymentDTO(paymentID, name);
                    if (this.listPayments == null) {
                        this.listPayments = new ArrayList<>();
                    }
                    this.listPayments.add(dto);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}
