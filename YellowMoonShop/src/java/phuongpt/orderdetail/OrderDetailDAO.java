/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.orderdetail;

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
public class OrderDetailDAO implements Serializable {
private List<OrderDetailDTO> listDetails;

    public List<OrderDetailDTO> getListDetails() {
        return listDetails;
    }

    public void findAllDetails(String orderID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT detailID, p.name, o.quantity, o.price "
                        + "FROM tblOrderDetail o, tblProduct p "
                        + "WHERE orderID = ? "
                        + "AND o.productID = p.productID";
                stm = con.prepareStatement(sql);
                stm.setString(1, orderID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String detailID = rs.getString("detailID");
                    String product = rs.getString("name");
                    int quantity = rs.getInt("quantity");
                    double price = rs.getDouble("price");
                    OrderDetailDTO dto = new OrderDetailDTO(detailID, orderID, product, price, quantity);
                    if (this.listDetails == null) {
                        this.listDetails = new ArrayList<>();
                    }
                    this.listDetails.add(dto);
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
    
    public boolean insertNewDetail(String orderID, String id, double price, int quantity)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO tblOrderDetail(orderID, productID, price, quantity) "
                        + "VALUES(?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, orderID);
                stm.setString(2, id);
                stm.setDouble(3, price);
                stm.setInt(4, quantity);
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

}
