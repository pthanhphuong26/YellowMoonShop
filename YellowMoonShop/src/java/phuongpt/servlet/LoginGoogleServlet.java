package phuongpt.servlet;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import phuongpt.util.GoogleUtils;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import phuongpt.user.GoogleDTO;
import phuongpt.user.UserDAO;
import phuongpt.user.UserDTO;
import phuongpt.util.PasswordEncryption;

/**
 *
 * @author PhuongPT
 */
@WebServlet(urlPatterns = {"/LoginGoogleServlet"})
public class LoginGoogleServlet extends HttpServlet {

    private static final String DEFAULT_PASSWORD = "Q:nC3$v~]/'.R`kc";
    private static final Logger LOGGER = Logger.getLogger(LoginGoogleServlet.class);

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
        String code = request.getParameter("code");
        String url = "login.jsp";
        if (code == null || code.isEmpty()) {

        } else {
            try {
                String token = GoogleUtils.getToken(code);
                GoogleDTO dto = GoogleUtils.getUserInfo(token);
                String password = PasswordEncryption.encryptPassword(DEFAULT_PASSWORD);
                String email = dto.getEmail();
                String name = dto.getName();
                if (name == null) {
                    name = email.split("@")[0];
                }
                UserDAO dao = new UserDAO();
                UserDTO userDTO = dao.checkLogin(email, password);
                if (userDTO == null) {
                    userDTO = new UserDTO(email, name, password, "", "", "User", "Active");
                    dao.createAccount(userDTO);
                }
                HttpSession session = request.getSession();
                session.setAttribute("USER_DTO", userDTO);
                url = "SearchCakeServlet";
            } catch (SQLException ex) {
                LOGGER.error("LoginGoogleServlet _ SQL " + ex.getMessage());
            } catch (NamingException ex) {
                LOGGER.error("LoginGoogleServlet _ Naming " + ex.getMessage());
            } catch (NoSuchAlgorithmException ex) {
                LOGGER.error("LoginGoogleServlet _ NoSuchAlgorithm " + ex.getMessage());
            } finally {
                response.sendRedirect(url);
                out.close();
            }
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
