/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProfileController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // 3 dòng này mới chèn cho your oder 
        
        System.out.println("[DEBUG] User in session: " + user);
        if (user != null) {
            System.out.println("[DEBUG] user.getID(): " + user.getID());
        }
        if (user == null || user.getRole_ID() == 0) {
            session.setAttribute("redirectAfterLogin", "profile");
            request.getRequestDispatcher("signin?action=signin").forward(request, response);
            return;
        }
        
        UserDao userDAO = new UserDao();
        user = userDAO.getUserById(user.getID());
        session.setAttribute("user", user); // Cập nhật session

        // Xử lý view đơn hàng
        String view = request.getParameter("view");
        if ("orders".equals(view)) {
            dao.OrderDao orderDao = new dao.OrderDao();
            java.util.List<model.Order> orderList = orderDao.getOrdersByUserId(user.getID());
            // 4 dòng này mới them cho your oder benh profile 
            System.out.println("[DEBUG] User ID: " + user.getID());
            System.out.println("[DEBUG] orderList.size(): " + orderList.size());
            for (model.Order o : orderList) {
                System.out.println("[DEBUG] Order: " + o.getOrder_ID() + " - " + o.getOrder_Date());
            }
            request.setAttribute("orderList", orderList);
            request.setAttribute("showOrders", true);
            // them cho puschase history của profile
        } else if ("history".equals(view)) {
            dao.OrderDao orderDao = new dao.OrderDao();
            java.util.List<model.Order> orderList = orderDao.getOrdersByUserId(user.getID());
            for (model.Order order : orderList) {
                java.util.List<String> productNames = orderDao.getProductNamesByOrderId(order.getOrder_ID());
                order.setProductNames(productNames);
            }
            request.setAttribute("orderList", orderList);
            request.setAttribute("showHistory", true);
        }

        request.getRequestDispatcher("Profile.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("SignIn.jsp");
            return;
        }

        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        int gender = Integer.parseInt(request.getParameter("gender"));
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Cập nhật thông tin vào đối tượng user
        user.setUsername(username);
        user.setFullname(fullname);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        user.setGender(gender);

        UserDao userDAO = new UserDao();
        boolean updateSuccess = userDAO.updateUserProfile(user);

        // Xử lý đổi mật khẩu nếu có
        if (newPassword != null && !newPassword.isEmpty() && newPassword.equals(confirmPassword)) {
            userDAO.updatePasswordById(user.getID(), newPassword);
        }

        if (updateSuccess) {
            request.setAttribute("message", "Update information successfully!");
        } else {
            request.setAttribute("error", "Update information failed.");
        }

        // Lấy lại thông tin mới nhất và forward
        user = userDAO.getUserById(user.getID());
        session.setAttribute("user", user); // Cập nhật session

        request.getRequestDispatcher("Profile.jsp").forward(request, response);
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
