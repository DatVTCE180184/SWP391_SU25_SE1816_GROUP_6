/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDao;
import dao.OrderDao;
import dao.ProductDao;
import dao.ReviewDao;
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
@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

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
            out.println("<title>Servlet AdminController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminController at " + request.getContextPath() + "</h1>");
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

        if ("Category Management (Categories)".equals(section)) {
            CategoryDao categoryDao = new CategoryDao();
            request.setAttribute("categories", categoryDao.getAllCategory());
        }

        if ("Product Management (Products)".equals(section)) {
            String action = request.getParameter("action");
            if ("addForm".equals(action)) {
                // Lấy danh sách category để hiển thị trong form
                CategoryDao categoryDao = new CategoryDao();
                request.setAttribute("categories", categoryDao.getAllCategory());
                request.getRequestDispatcher("AddProduct.jsp").forward(request, response);
            }
        }

        if ("Customer Feedback (Feedbacks)".equals(section)) {
            ReviewDao reviewDao = new ReviewDao();
            request.setAttribute("reviews", reviewDao.getAllReviews());
        }

        request.getRequestDispatcher("Admin.jsp").forward(request, response);
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
        String section = request.getParameter("section");
        OrderDao orderDao = new OrderDao();

        // Xử lý feedback trước khi redirect
        if ("Customer Feedback (Feedbacks)".equals(request.getParameter("section"))) {
            ReviewDao reviewDao = new ReviewDao();

            // Thêm feedback
            String addUserIdStr = request.getParameter("addUserId");
            if (addUserIdStr != null && !addUserIdStr.isEmpty()) {
                try {
                    int userId = Integer.parseInt(request.getParameter("addUserId"));
                    int productId = Integer.parseInt(request.getParameter("addProductId"));
                    int orderId = Integer.parseInt(request.getParameter("addOrderId"));
                    int rating = Integer.parseInt(request.getParameter("addRating"));
                    String comment = request.getParameter("addComment");

                    reviewDao.addReview(userId, productId, orderId, rating, comment);
                    System.out.println("✅ Đã thêm feedback thành công!");
                } catch (Exception ex) {
                    System.out.println("❌ Lỗi khi thêm feedback: " + ex.getMessage());
                    ex.printStackTrace();
                }
            }

            // Sửa feedback
            if (request.getParameter("editReviewId") != null) {
                int reviewId = Integer.parseInt(request.getParameter("editReviewId"));
                int rating = Integer.parseInt(request.getParameter("editRating"));
                String comment = request.getParameter("editComment");
                reviewDao.updateReview(reviewId, rating, comment);
            }

            // Xóa feedback
            if (request.getParameter("deleteReviewId") != null) {
                int reviewId = Integer.parseInt(request.getParameter("deleteReviewId"));
                reviewDao.deleteReview(reviewId);
            }

            // Redirect lại trang feedback để hiển thị dữ liệu mới
            response.sendRedirect("admin?section=Customer Feedback (Feedbacks)");
            return;
        }
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
