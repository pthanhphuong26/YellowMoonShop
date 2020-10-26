/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.order;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import javax.naming.NamingException;
import phuongpt.util.DBHelper;

/**
 *
 * @author PhuongPT
 */
public class OrderDAO implements Serializable {

    private SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

    public String insertNewOrder(String userID, double total, String orderDate,
            String name, String phone, String address, String payment)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO tblOrder(userID, total, orderDate, name, phone, address, paymentID, paymentStatus) "
                        + "OUTPUT inserted.orderID "
                        + "VALUES(?, ?, ?, ?, ?, ?, (SELECT paymentID FROM tblPayment WHERE name = ?), ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setDouble(2, total);
                stm.setString(3, orderDate);
                stm.setString(4, name);
                stm.setString(5, phone);
                stm.setString(6, address);
                stm.setString(7, payment);
                stm.setString(8, "Not Paid");
                rs = stm.executeQuery();
                if (rs.next()) {
                    return rs.getString("orderID");
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
        return "";
    }

    public OrderDTO findOrder(String userID, String orderID)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        OrderDTO dto = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT orderID, userID, total, orderDate, o.name, phone, paymentStatus, "
                        + "address, p.name as payment "
                        + "FROM tblOrder o, tblPayment p "
                        + "WHERE userID = ? "
                        + "AND orderID = ? "
                        + "AND o.paymentID = p.paymentID";
                stm = con.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setString(2, orderID);

                rs = stm.executeQuery();
                if (rs.next()) {
                    double total = rs.getDouble("total");
                    String orderDate = sdf.format(rs.getTimestamp("orderDate"));
                    String name = rs.getString("name");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String payment = rs.getString("payment");  
                    String paymentStatus = rs.getString("paymentStatus");  
                    dto = new OrderDTO(orderID, userID, total, orderDate, name, phone, address, payment, paymentStatus);
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
        return dto;
    }

}
