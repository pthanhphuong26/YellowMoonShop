/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import phuongpt.product.ProductDAO;
import phuongpt.product.ProductDTO;
import phuongpt.user.UserDTO;

/**
 *
 * @author PhuongPT
 */
@WebServlet(name = "ShowDetailServlet", urlPatterns = {"/ShowDetailServlet"})
public class ShowDetailServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ShowDetailServlet.class);

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
        String url = "showDetail.jsp";
        HttpSession session = request.getSession();
        UserDTO userDTO = (UserDTO) session.getAttribute("USER_DTO");
        String role;
        if (userDTO == null) {
            role = "Guest";
        } else {
            role = userDTO.getRole();
        }
        if (role.equals("Admin")) 
            url = "showDetailUpdate.jsp";
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            request.setAttribute("CURRENT_DATE", sdf.format(date));
            String proID = request.getParameter("id");
            ProductDAO productDAO = new ProductDAO();
            ProductDTO productDTO = productDAO.findProductById(proID);
            if (productDTO != null) {
                request.setAttribute("PRODUCT_DTO", productDTO);
            }
                       
        } catch (SQLException ex) {
            LOGGER.error("ShowDetailServlet _ SQL " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.error("ShowDetailServlet _ Naming " + ex.getMessage());
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
