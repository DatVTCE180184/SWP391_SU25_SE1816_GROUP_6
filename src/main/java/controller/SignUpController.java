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
@WebServlet(name="SignUpController", urlPatterns={"/signup"})
public class SignUpController extends HttpServlet {
   
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
            out.println("<title>Servlet SignUpController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignUpController at " + request.getContextPath () + "</h1>");
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
        request.getRequestDispatcher("SignUp.jsp").forward(request, response);
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
             String action = request.getParameter("action");
        if (action == null || !action.equalsIgnoreCase("Signup")) {
            response.sendRedirect("Signup.jsp");
            return;
        }

        HttpSession session = request.getSession();

        // Lấy thông tin từ form với null check
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender_id");
        String avatar = request.getParameter("avatar");

        // Trim các giá trị nếu không null
        username = (username != null) ? username.trim() : "";
        password = (password != null) ? password.trim() : "";
        confirmPassword = (confirmPassword != null) ? confirmPassword.trim() : "";
        email = (email != null) ? email.trim() : "";
        phone = (phone != null) ? phone.trim() : "";
        address = (address != null) ? address.trim() : "";

        // Giữ lại giá trị nhập để hiển thị lại khi lỗi
        request.setAttribute("username", username);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);

        // Validate đầu vào cơ bản
        if (username.isEmpty() || password.isEmpty() || confirmPassword.isEmpty() ||
                email.isEmpty() || phone.isEmpty() || address.isEmpty() || gender == null || gender.isEmpty()) {
            session.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("Signup.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            session.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("Signup.jsp").forward(request, response);
            return;
        }

        try {
            int genderId = Integer.parseInt(gender);
            String defaultAvatar = (avatar == null || avatar.isEmpty()) ? "default.png" : avatar;

            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setGender(genderId);
            user.setAvatar(defaultAvatar);
            user.setRole_ID(3);

            UserDao userDAO = new UserDao();
            boolean isRegistered = userDAO.register(user);

            if (isRegistered) {
                session.setAttribute("success", "Account registered successfully! Please login.");
                response.sendRedirect("Lognin.jsp");
            } else {
                session.setAttribute("error", "Registration failed! Username, Email, or Phone may already exist.");
                request.getRequestDispatcher("SignUp.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Internal server error: " + e.getMessage());
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
        }
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
