/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "OrderController", urlPatterns = {"/order"})
public class OrderController extends HttpServlet {

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
            out.println("<title>Servlet OrderController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();

        // Dữ liệu người dùng
        ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");

        User user = (User) session.getAttribute("user");
        String userID = request.getParameter("userId");

        // Thông tin nhận hàng
        String fullName = request.getParameter("fullname") != null ? request.getParameter("fullname").trim() : "";;
        String phone = request.getParameter("phone") != null ? request.getParameter("phone").trim() : "";;

        // Ghi chú 
        String note = request.getParameter("note") != null ? request.getParameter("note").trim() : "";

        // Địa chỉ nhận hàng & phương thức thanh toán
        String Payment_Method = request.getParameter("Payment_Method") != null ? request.getParameter("Payment_Method").trim() : "COD";;

        OrderDao orDao = new OrderDao();
        String address = "";
        try {

            if ("COD".equals(Payment_Method)) {
                String province = request.getParameter("provinceName") != null ? request.getParameter("provinceName").trim() : "";
                String district = request.getParameter("districtName") != null ? request.getParameter("districtName").trim() : "";
                String ward = request.getParameter("wardName") != null ? request.getParameter("wardName").trim() : "";
                String street = request.getParameter("street") != null ? request.getParameter("street").trim() : "";
                address = street + ", " + ward + ", " + district + ", " + province;
            } else if ("InStore".equals(Payment_Method)) {
                address = "Nhận tại cửa hàng";
            }

            int newOrder = orDao.createOrder(cart, userID, fullName, phone, note, Payment_Method, address);

            if (newOrder == 1) {
                // Xóa giỏ hàng sau khi đặt hàng thành công
                session.removeAttribute("cart");
                request.setAttribute("OrderCompletedOrNot", "completed");
            } else {
                request.setAttribute("OrderCompletedOrNot", "failed");
                System.out.println("userID: " + userID);
                System.out.println("cart: " + cart);
                System.out.println("Payment_Method: " + Payment_Method);
                System.out.println("address: " + address);
            }
            request.getRequestDispatcher("CheckOut.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("❌ Đặt hàng thất bại với thông tin:");
            System.out.println("userID: " + userID);
            System.out.println("fullname: " + fullName);
            System.out.println("phone: " + phone);
            System.out.println("note: " + note);
            System.out.println("Payment_Method: " + Payment_Method);
            System.out.println("address: " + address);

            e.printStackTrace();
            request.setAttribute("OrderCompletedOrNot", "failed");
            request.getRequestDispatcher("CheckOut.jsp").forward(request, response);
        }
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
