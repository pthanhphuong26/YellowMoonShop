/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuongpt.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import phuongpt.product.ProductDAO;

/**
 *
 * @author PhuongPT
 */
@WebServlet(name = "AddCakeServlet", urlPatterns = {"/AddCakeServlet"})
public class AddCakeServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AddCakeServlet.class);

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
        String url = "SearchCakeServlet";
        
        ProductDAO productDAO = new ProductDAO();

        try {
            boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
            if (isMultiPart) {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List itemList = null;
                try {
                    itemList = upload.parseRequest(request);
                } catch (FileUploadException ex) {
                    LOGGER.error("AddCakeServlet _ FileUpload " + ex.getMessage());
                }
                Iterator iter = itemList.iterator();
                Hashtable params = new Hashtable();
                String fileName = null;
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.isFormField()) {
                        params.put(item.getFieldName(), item.getString());
                    } else {
                        try {
                            String itemName = item.getName();
                            fileName = itemName.substring(itemName.lastIndexOf("\\") + 1);
                            String realPath = getServletContext().getRealPath("/") + "image\\" + fileName;
                            File savedFile = new File(realPath);
                            item.write(savedFile);
                        } catch (Exception ex) {
                            LOGGER.error("AddCakeServlet" + ex.getMessage());
                        }
                    }
                }
                String name = (String) params.get("txtName");
                double price = Double.parseDouble((String) params.get("txtPrice"));
                int quantity = Integer.parseInt((String) params.get("txtQuantity"));
                String category = (String) params.get("cbCategory");
                String creationDate = (String) params.get("pdCreationDate");
                String expirationDate = (String) params.get("pdExpirationDate");
                String description = (String) params.get("txtDescription");

                String image = "";
                if (fileName.trim().length() > 0) {
                    image = "image/" + fileName;
                }
                productDAO.createProduct(name, price, quantity, image, description, creationDate, expirationDate, category);
            }
        } catch (SQLException ex) {
            LOGGER.error("AddCakeServlet _ SQL " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.error("AddCakeServlet _ Naming " + ex.getMessage());
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
