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
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import javax.websocket.Session;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "SignInController", urlPatterns = { "/signin" })
public class SignInController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SignInController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignInController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = "";
        action = request.getParameter("action");

        switch (action) {
            case "signin":
                request.getRequestDispatcher("SignIn.jsp").forward(request, response);
                break;
            case "logout":
                // Xóa session và cookies khi đăng xuất
                session.invalidate();
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        cookie.setMaxAge(0); // Xóa cookie
                        response.addCookie(cookie);
                    }
                }
                response.sendRedirect("home");
                break;

        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDao dao = new UserDao();

        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate input
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            session.setAttribute("error", "Username and password are required!");
            request.getRequestDispatcher("signin.jsp").forward(request, response);
            return;
        }

        try {
            // Gọi method login từ UsersDAO
            User user = dao.signIn(username.trim(), password.trim());

            if (user != null) {
                // Đăng nhập thành công - set session attributes
               if (session.getAttribute("user") != null){
                    session.removeAttribute("user");
               }
                session.setAttribute("user", user);
                session.setAttribute("username", user.getUsername());
                session.setAttribute("userId", user.getID());
                session.setAttribute("userRole", user.getRole_ID());
                session.setAttribute("userEmail", user.getEmail());

                // Tạo cookies
                Cookie userNameCookie = new Cookie("user", user.getUsername());
                Cookie userRoleCookie = new Cookie("role", String.valueOf(user.getRole_ID()));
                userNameCookie.setMaxAge(60 * 60 * 24); // 24 hours
                userRoleCookie.setMaxAge(60 * 60 * 24); // 24 hours
                response.addCookie(userNameCookie);
                response.addCookie(userRoleCookie);
                
                String redirect = (String) session.getAttribute("redirectAfterLogin");
                if (redirect != null) {
                    session.removeAttribute("redirectAfterLogin");
                   response.sendRedirect(redirect);
                    return;
                }

                // Redirect based on user role
                int role = user.getRole_ID();
                if (role == 1) { // Admin
                    response.sendRedirect("admin");
                } else if (role == 2) { // Staff
                    response.sendRedirect("home_staff.jsp");
                } else if (role == 3) { // Customer
                    response.sendRedirect("home");
                } else {
                    response.sendRedirect("home");
                }
                return;
            } else {
                // Đăng nhập thất bại
                session.setAttribute("error", "Invalid username or password!");
                request.getRequestDispatcher("SignIn.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Login error: " + e.getMessage());
            request.getRequestDispatcher("SignIn.jsp").forward(request, response);
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
