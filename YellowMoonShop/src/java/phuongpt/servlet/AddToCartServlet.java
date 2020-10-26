/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import phuongpt.cart.CartObject;
import phuongpt.payment.PaymentDAO;
import phuongpt.payment.PaymentDTO;
import phuongpt.product.ProductDAO;
import phuongpt.product.ProductDTO;

/**
 *
 * @author PhuongPT
 */
@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCartServlet"})
public class AddToCartServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AddToCartServlet.class);

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = "ShowDetailServlet";
        int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
        String proID = request.getParameter("txtProductID");
        try {
            HttpSession session = request.getSession();
            CartObject cart = (CartObject) session.getAttribute("CART");
            if (cart == null) {
                cart = new CartObject();
            }
            ProductDAO productDAO = new ProductDAO();
            ProductDTO productDTO = productDAO.findProductById(proID);
            int availableQuantity = productDTO.getQuantity();

            Map<String, ProductDTO> listMap = cart.getItems();
            int cartQuantity = 0;
            int totalQuantity = 0;
            double totalPrice = 0.0;
            if (listMap != null) {
                if (listMap.get(proID) != null) {
                    cartQuantity = listMap.get(proID).getQuantity();
                }
            }
            if ((cartQuantity + quantity) > availableQuantity) {
                request.setAttribute("ADD_TO_CART_ERROR",
                        "Add to cart fail! The quantity is larger than the available quantity.");
            } else {
                cart.addItemToCart(proID, quantity);
                listMap = cart.getItems();
                for (String key : listMap.keySet()) {
                    if (listMap.get(key) != null) {
                        totalQuantity += listMap.get(key).getQuantity();
                        totalPrice += (listMap.get(key).getPrice() * listMap.get(key).getQuantity());
                    }
                }
            }

            
            PaymentDAO paymentDAO = new PaymentDAO();
            paymentDAO.findAllPayments();
            List<PaymentDTO> listCategories = paymentDAO.getListPayments();
            session.setAttribute("LIST_PAYMENTS", listCategories);
            
            session.setAttribute("CART", cart);
            session.setAttribute("TOTAL_QUANTITY", totalQuantity);
            session.setAttribute("TOTAL_PRICE", totalPrice);
            
            request.setAttribute("PRODUCT_DTO", productDTO);
        } catch (SQLException ex) {
            LOGGER.error("AddToCartServlet _ SQL " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.error("AddToCartServlet _ Naming " + ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
