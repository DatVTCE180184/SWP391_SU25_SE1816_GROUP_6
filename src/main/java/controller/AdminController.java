/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.OrderDao;
import dao.ProductDao;
import dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="AdminController", urlPatterns={"/admin"})
public class AdminController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Lấy section, mặc định là Dashboard
        String section = request.getParameter("section");
        if (section == null || section.isEmpty()) {
            section = "Dashboard";
        }
        request.setAttribute("section", section);

        // Lấy dữ liệu tổng quan cho dashboard
        ProductDao productDao = new ProductDao();
        UserDao userDao = new UserDao();
        OrderDao orderDao = new OrderDao();

        int totalProducts = productDao.getAllProduct().size();
        int totalUsers = userDao.getAllUser().size();
        int totalOrders = orderDao.getTotalRevenueAndOrders().getTotalOrders();
        double totalRevenue = orderDao.getTotalRevenueAndOrders().getTotalRevenue();
//        try {
//            java.sql.Connection conn = orderDao.conn;
//            java.sql.PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*), COALESCE(SUM(Total_Amount),0) FROM Orders");
//            java.sql.ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                totalOrders = rs.getInt(1);
//                totalRevenue = rs.getDouble(2);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalRevenue", totalRevenue);

        // Thống kê trạng thái đơn hàng
        request.setAttribute("orderStatusStats", orderDao.getOrderStatusStats());
        // Top 5 sản phẩm bán chạy
        request.setAttribute("topSellingProducts", orderDao.getTopSellingProducts(5));
        // Doanh thu 6 tháng gần nhất
        request.setAttribute("monthlyRevenue", orderDao.getMonthlyRevenue(6));

        if ("Order Management (Orders)".equals(section)) {
            request.setAttribute("orders", orderDao.getAllOrders());
        }

        request.getRequestDispatcher("Admin.jsp").forward(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
           String section = request.getParameter("section");
        OrderDao orderDao = new OrderDao();
        // Cập nhật trạng thái
        if (request.getParameter("orderId") != null && request.getParameter("status") != null) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            orderDao.updateOrderStatus(orderId, status);
        }
        // Xóa đơn hàng
        if (request.getParameter("deleteOrderId") != null) {
            int orderId = Integer.parseInt(request.getParameter("deleteOrderId"));
            orderDao.deleteOrder(orderId);
        }
        // Quay lại trang quản lý đơn hàng
        response.sendRedirect("admin?section=Order Management (Orders)");
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
