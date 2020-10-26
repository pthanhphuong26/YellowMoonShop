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
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import phuongpt.category.CategoryDAO;
import phuongpt.category.CategoryDTO;
import phuongpt.product.ProductDAO;
import phuongpt.product.ProductDTO;
import phuongpt.user.UserDTO;

/**
 *
 * @author PhuongPT
 */
@WebServlet(name = "SearchCakeServlet", urlPatterns = {"/SearchCakeServlet"})
public class SearchCakeServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SearchCakeServlet.class);

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
        String url = "home.jsp";
        HttpSession session = request.getSession();
        UserDTO userDTO = (UserDTO) session.getAttribute("USER_DTO");
        String role;
        if (userDTO == null) {
            role = "Guest";
        } else {
            role = userDTO.getRole();
        }
        String searchValue = request.getParameter("txtSearchValue");
        String category = request.getParameter("rdCategory");
        String rangeMoney = request.getParameter("rdPrice");
        String pageStr = request.getParameter("page");

        if (searchValue == null) {
            searchValue = "";
        }
        if (category == null) {
            category = "";
        }
        if (rangeMoney == null) {
            rangeMoney = "";
        }

        try {
            CategoryDAO categoryDAO = new CategoryDAO();
            categoryDAO.findAllCategories();
            List<CategoryDTO> listCategories = categoryDAO.getListCategories();
            session.setAttribute("LIST_CATEGORIES", listCategories);

            double lower = 0, upper = 0;
            switch (rangeMoney) {
                case "range1":
                    upper = 100000;
                    break;
                case "range2":
                    lower = 100000;
                    upper = 500000;
                    break;
                case "range3":
                    lower = 500000;
                    upper = 1000000;
                    break;
                case "range4":
                    lower = 1000000;
                    upper = 10000000;
                    break;
                case "":
                    upper = 10000000;
                    break;
            }
            ProductDAO productDAO = new ProductDAO();

            int page = 1;
            int recordsPerPage = 20;
            List<ProductDTO> listProducts = null;
            int noOfRecords = 0;
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
            if (role.equals("Admin")) {
                productDAO.findProductsForAdmin(searchValue, lower, upper,
                        category, (page - 1) * recordsPerPage, recordsPerPage);
                listProducts = productDAO.getListProducts();
                noOfRecords = productDAO.countAllProduct();
            } else {
                productDAO.findListProductByFilter(searchValue, lower, upper,
                        category, (page - 1) * recordsPerPage, recordsPerPage);
                listProducts = productDAO.getListProducts();
                noOfRecords = productDAO.countListProductByFilter(searchValue, lower, upper, category);
            }

            int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
            request.setAttribute("LIST_PRODUCTS", listProducts);
            request.setAttribute("NO_OF_PAGES", noOfPages);
            request.setAttribute("CURRENT_PAGE", page);
            request.setAttribute("SEARCH_VALUE", searchValue);
            request.setAttribute("CATEGORY", category);
            request.setAttribute("RANGE_MONEY", rangeMoney);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            request.setAttribute("CURRENT_DATE", sdf.format(date));
        } catch (SQLException ex) {
            LOGGER.error("SearchCakeServlet _ SQL " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.error("SearchCakeServlet _ Naming " + ex.getMessage());
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
