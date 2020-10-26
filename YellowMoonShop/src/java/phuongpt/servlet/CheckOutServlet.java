/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import phuongpt.order.OrderDAO;
import phuongpt.orderdetail.OrderDetailDAO;
import phuongpt.product.ProductDAO;
import phuongpt.product.ProductDTO;
import phuongpt.user.UserDAO;
import phuongpt.user.UserDTO;
import phuongpt.util.PasswordEncryption;

/**
 *
 * @author PhuongPT
 */
@WebServlet(name = "CheckOutServlet", urlPatterns = {"/CheckOutServlet"})
public class CheckOutServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CheckOutServlet.class);
    private static final String DEFAULT_PASSWORD = "Q:nC3$v~]/'.R`kc";

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
        String url = "viewCart.jsp";

        try {
            HttpSession session = request.getSession();

            if (session != null) {
                CartObject cart = (CartObject) session.getAttribute("CART");
                if (cart != null) {
                    Map<String, ProductDTO> items = cart.getItems();
                    if (items != null) {
                        OrderDAO orderDAO = new OrderDAO();
                        String name = request.getParameter("txtName");
                        String address = request.getParameter("txtAddress");
                        String phone = request.getParameter("txtPhone");
                        String payment = request.getParameter("rdPayment");
                        double total = Double.parseDouble(request.getParameter("txtTotal"));
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                        Date date = new Date();
                        String orderDate = sdf.format(date);
                        UserDTO userDTO = (UserDTO) session.getAttribute("USER_DTO");
                        if (userDTO == null) {
                            UserDAO userDAO = new UserDAO();
                            String userID = orderDate + phone;
                            userDTO = new UserDTO(userID, name, PasswordEncryption.encryptPassword(DEFAULT_PASSWORD), phone, address, "Guest", "Active");
                            userDAO.createAccount(userDTO);
                        }

                        String orderID = orderDAO.insertNewOrder(userDTO.getUserID(), total, orderDate, name, phone, address, payment);
                        if (orderID != null) {
                            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
                            for (String id : items.keySet()) {
                                ProductDAO productDAO = new ProductDAO();
                                int oldQuantity = productDAO.findProductById(id).getQuantity();
                                int quantity = items.get(id).getQuantity();
                                double price = items.get(id).getPrice() * quantity;
                                boolean detailResult = orderDetailDAO.insertNewDetail(orderID, id, price, quantity);
                                if (detailResult) {
                                    productDAO.updateBookQuantity(id, oldQuantity - quantity);
                                    session.removeAttribute("CART");
                                    request.setAttribute("CHECKOUT_RESULT", "suscess");
                                    request.setAttribute("ORDERID", orderID);
                                }
                            }
                        } else {
                            request.setAttribute("CHECKOUT_RESULT", "fail");
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            LOGGER.error("CheckOutServlet _ SQL " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.error("CheckOutServlet _ Naming " + ex.getMessage());
        } catch (NoSuchAlgorithmException ex) {
            LOGGER.error("CheckOutServlet _ NoSuchAlgorithm " + ex.getMessage());
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
