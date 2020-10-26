/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import phuongpt.cart.CartObject;
import phuongpt.product.ProductDTO;

/**
 *
 * @author PhuongPT
 */
@WebServlet(name = "RemoveSelectedProductsServlet", urlPatterns = {"/RemoveSelectedProductsServlet"})
public class RemoveSelectedProductsServlet extends HttpServlet {

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
        int totalQuantity = 0;
        double totalPrice = 0;
        try {
            HttpSession session = request.getSession();
            CartObject cart = (CartObject) session.getAttribute("CART");
            if (cart != null) {
                String proID = request.getParameter("txtProductID");
                cart.removeItemFromCart(proID);
                Map<String, ProductDTO> listMap = cart.getItems();
                if (listMap != null) {
                    for (String key : listMap.keySet()) {
                        if (listMap.get(key) != null) {
                            totalQuantity += listMap.get(key).getQuantity();
                            totalPrice += (listMap.get(key).getPrice() * listMap.get(key).getQuantity());
                        }
                    }
                }
                session.setAttribute("CART", cart);
                session.setAttribute("TOTAL_QUANTITY", totalQuantity);
                session.setAttribute("TOTAL_PRICE", totalPrice);
            }

        } finally {
            response.sendRedirect(url);
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
