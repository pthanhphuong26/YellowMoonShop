/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.cart;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.naming.NamingException;
import phuongpt.product.ProductDAO;
import phuongpt.product.ProductDTO;

/**
 *
 * @author PhuongPT
 */
public class CartObject implements Serializable {

    private Map<String, ProductDTO> items;

    public Map<String, ProductDTO> getItems() {
        return items;
    }

    public void addItemToCart(String id, int quantity) throws SQLException, NamingException {
        if (this.items == null) {
            this.items = new HashMap<>();
        }
        ProductDAO dao = new ProductDAO();
        ProductDTO dto = dao.findProductById(id);
        dto.setQuantity(quantity);
        if (this.items.containsKey(id)) {
            quantity += this.items.get(id).getQuantity();
            dto.setQuantity(quantity);
        }
        this.items.put(id, dto);
    }
    
    public void updateItemToCart(String id, int quantity) throws SQLException, NamingException {
        if (this.items == null) {
            this.items = new HashMap<>();
        }
        ProductDAO dao = new ProductDAO();
        ProductDTO dto = dao.findProductById(id);
        dto.setQuantity(quantity);
        this.items.put(id, dto);
    }
    
    public void removeItemFromCart(String id) {
        if (this.items == null) {
            return;
        }
        if (this.items.containsKey(id)) {
            this.items.remove(id);
            if (this.items.isEmpty()) {
                this.items = null;
            }
        }
    }

}
