/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.user;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import phuongpt.util.DBHelper;

/**
 *
 * @author PhuongPT
 */
public class UserDAO implements Serializable {

    public UserDTO checkLogin(String userID, String encryptPassword)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        UserDTO result = null;

        try {
            con = DBHelper.makeConnection();
            String sql = "SELECT userID, u.name, password, phone, address, r.name as roleName, status "
                    + "FROM tblUser u, tblRole r "
                    + "WHERE userID = ? AND password = ? AND status = 'Active' "
                    + "AND (r.name = 'User' OR r.name = 'Admin') AND r.roleID = u.roleID";

            stm = con.prepareStatement(sql);
            stm.setString(1, userID);
            stm.setString(2, encryptPassword);
            rs = stm.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                String role = rs.getString("roleName");
                String status = rs.getString("status");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                result = new UserDTO(userID, name, encryptPassword, phone, address, role, status);
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

        return result;
    }
    
    public boolean createAccount(UserDTO dto) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO tblUser(userID, name, password, phone, address, roleID, status) "
                        + "VALUES(?, ?, ?, ?, ?, (SELECT roleID FROM tblRole WHERE name = ?), 'Active')";
                stm = con.prepareStatement(sql);
                stm.setString(1, dto.getUserID());
                stm.setString(2, dto.getName());
                stm.setString(3, dto.getPassword());
                stm.setString(4, dto.getPhone());
                stm.setString(5, dto.getAddress());
                stm.setString(6, dto.getRole());
                int row = stm.executeUpdate();
                
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null)
                stm.close();
            if (con != null)
                con.close();
        }
        return false;
    }
    
}
