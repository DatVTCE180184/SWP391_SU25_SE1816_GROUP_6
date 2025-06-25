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
@WebServlet(name="ForgetPasswordController", urlPatterns={"/forgetpass"})
public class ForgetPasswordController extends HttpServlet {
   
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
        request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
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
          String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession();

        // Step 1: Only check email if newPassword and confirmPassword are not provided
        if (newPassword == null && confirmPassword == null) {
            request.setAttribute("email", email);
            UserDao usersDAO = new UserDao();
            User user = usersDAO.getUserByEmail(email);
            if (user == null) {
                session.setAttribute("error", "Email does not exist in the system!");
                request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
            } else {
                request.setAttribute("emailChecked", true);
                request.setAttribute("email", email);
                request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
            }
            return;
        }

        // Step 2: User is entering new password and confirmation
        request.setAttribute("email", email);
        request.setAttribute("emailChecked", true);
        if (newPassword == null || confirmPassword == null || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            session.setAttribute("error", "Please enter both new password and confirm password!");
            request.getRequestDispatcher("ForgetPassword.jsp").forward(request, response);
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("ForgetPassword.jsp").forward(request, response);
            return;
        }
        UserDao usersDAO = new UserDao();
        User user = usersDAO.getUserByEmail(email);
        if (user == null) {
            session.setAttribute("error", "Email does not exist in the system!");
            request.getRequestDispatcher("ForgetPassword.jsp").forward(request, response);
            return;
        }
        boolean updated = usersDAO.updatePasswordByEmail(email, newPassword);
        if (updated) {
            session.setAttribute("success", "Password changed successfully! Please sign in again.");
            response.sendRedirect("SignIn.jsp");
        } else {
            session.setAttribute("error", "An error occurred while updating the password. Please try again!");
            request.getRequestDispatcher("ForgetPassword.jsp").forward(request, response);
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
