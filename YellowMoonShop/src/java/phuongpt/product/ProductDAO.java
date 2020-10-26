/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.product;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import phuongpt.util.DBHelper;

/**
 *
 * @author PhuongPT
 */
public class ProductDAO implements Serializable {

    private SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    private SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");

    private List<ProductDTO> listProducts;

    public List<ProductDTO> getListProducts() {
        return listProducts;
    }

    public ProductDTO findProductById(String proID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ProductDTO dto = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT productID, p.name, price, quantity, image, description, "
                        + "creationDate, expirationDate, c.name as category, status "
                        + "FROM tblProduct p, tblCategory c "
                        + "WHERE p.categoryID = c.categoryID "
                        + "AND productID = ? ";
                stm = con.prepareStatement(sql);
                stm.setString(1, proID);

                rs = stm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("name");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    String category = rs.getString("category");
                    String status = rs.getString("status");
                    String creationDate = sdf2.format(rs.getTimestamp("creationDate"));
                    String expirationDate = sdf2.format(rs.getTimestamp("expirationDate"));
                    dto = new ProductDTO(proID, name, image, description, creationDate, expirationDate, category, status, price, quantity);
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
    
    public void findProductsForAdmin(String searchValue, double lower, double upper, 
            String category, int offset, int rows)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        if (searchValue.equals(""))
            searchValue = null;
        else searchValue = "%" + searchValue + "%";
        if (category.equals(""))
            category = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT productID, p.name, price, quantity, image, description, "
                        + "creationDate, expirationDate, c.name as category, status "
                        + "FROM tblProduct p, tblCategory c "
                        + "WHERE p.categoryID = c.categoryID "
                        + "AND p.name LIKE ISNULL(? , p.name)  "
                        + "AND price BETWEEN ? AND ? "
                        + "AND c.name = ISNULL(? , c.name) "
                        + "ORDER BY creationDate DESC offset ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = con.prepareStatement(sql);
                stm.setString(1, searchValue );
                stm.setDouble(2, lower);
                stm.setDouble(3, upper);
                stm.setString(4, category);
                stm.setInt(5, offset);
                stm.setInt(6, rows);

                rs = stm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String name = rs.getString("name");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    String status = rs.getString("status");
                    String creationDate = sdf.format(rs.getTimestamp("creationDate"));
                    String expirationDate = sdf.format(rs.getTimestamp("expirationDate"));
                    ProductDTO dto = new ProductDTO(productID, name, image, description, creationDate, expirationDate, category, status, price, quantity);
                    if (this.listProducts == null) {
                        this.listProducts = new ArrayList<>();
                    }
                    this.listProducts.add(dto);
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

    public int countAllProduct()
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int count = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT count(productID) as count FROM tblProduct ";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    count = rs.getInt("count");
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
        return count;
    }
    
    public int countListProductByFilter(String searchValue, double lower, double upper, String category)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int count = 0;
        if (searchValue.equals(""))
            searchValue = null;
        else searchValue = "%" + searchValue + "%";
        if (category.equals(""))
            category = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT count(productID) as count "
                        + "FROM tblProduct p, tblCategory c "
                        + "WHERE p.categoryID = c.categoryID "
                        + "AND quantity > 0 "
                        + "AND status = 'Active' "
                        + "AND expirationDate >= GETDATE() "
                        + "AND p.name LIKE ISNULL(? , p.name)  "
                        + "AND price BETWEEN ? AND ? "
                        + "AND c.name = ISNULL(? , c.name) ";
                stm = con.prepareStatement(sql);
                stm.setString(1, searchValue );
                stm.setDouble(2, lower);
                stm.setDouble(3, upper);
                stm.setString(4, category);
              
                rs = stm.executeQuery();
                if (rs.next()) {
                    count = rs.getInt("count");
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
        return count;
    }
    
    public void findListProductByFilter(String searchValue, double lower, double upper, 
            String category, int offset, int rows)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        if (searchValue.equals(""))
            searchValue = null;
        else searchValue = "%" + searchValue + "%";
        if (category.equals(""))
            category = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT productID, p.name, price, quantity, image, description, "
                        + "creationDate, expirationDate, c.name as category, status "
                        + "FROM tblProduct p, tblCategory c "
                        + "WHERE p.categoryID = c.categoryID "
                        + "AND quantity > 0 "
                        + "AND status = 'Active' "
                        + "AND expirationDate >= GETDATE() "
                        + "AND p.name LIKE ISNULL(? , p.name)  "
                        + "AND price BETWEEN ? AND ? "
                        + "AND c.name = ISNULL(? , c.name) "
                        + "ORDER BY creationDate DESC offset ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = con.prepareStatement(sql);
                stm.setString(1, searchValue );
                stm.setDouble(2, lower);
                stm.setDouble(3, upper);
                stm.setString(4, category);
                stm.setInt(5, offset);
                stm.setInt(6, rows);

                rs = stm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String name = rs.getString("name");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    String status = rs.getString("status");
                    String creationDate = sdf.format(rs.getTimestamp("creationDate"));
                    String expirationDate = sdf.format(rs.getTimestamp("expirationDate"));
                    ProductDTO dto = new ProductDTO(productID, name, image, description, creationDate, expirationDate, category, status, price, quantity);
                    if (this.listProducts == null) {
                        this.listProducts = new ArrayList<>();
                    }
                    this.listProducts.add(dto);
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

    public boolean createProduct(String name, double price, int quantity, String image, String description,
            String creationDate, String expirationDate, String category)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO tblProduct(name, price, quantity, image, "
                        + "description, creationDate, expirationDate, categoryID, status) "
                        + "VALUES(?, ?, ?, ?, ?, ?, ?, (SELECT categoryID FROM tblCategory WHERE name = ?), 'Active')";
                stm = con.prepareStatement(sql);
                stm.setString(1, name);
                stm.setDouble(2, price);
                stm.setInt(3, quantity);
                stm.setString(4, image);
                stm.setString(5, description);
                stm.setString(6, creationDate);
                stm.setString(7, expirationDate);
                stm.setString(8, category);
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

    public boolean updateProduct(String productID, String name, double price, int quantity, String image, String description,
            String creationDate, String expirationDate, String category, String status)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE tblProduct SET name = ?, price = ?, quantity = ?, "
                        + "image = ?, description = ?, creationDate = ?, expirationDate = ?, "
                        + "categoryID = (SELECT categoryID FROM tblCategory WHERE name = ?), status = ? "
                        + "WHERE productID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, name);
                stm.setDouble(2, price);
                stm.setInt(3, quantity);
                stm.setString(4, image);
                stm.setString(5, description);
                stm.setString(6, creationDate);
                stm.setString(7, expirationDate);
                stm.setString(8, category);
                stm.setString(9, status);
                stm.setString(10, productID);
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

    public boolean updateBookQuantity(String id, int quantity) 
            throws SQLException, NamingException{
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE tblProduct SET quantity = ? "
                        + "WHERE productID = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, quantity);
                stm.setString(2, id);
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
