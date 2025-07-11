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
import java.util.List;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "UserController", urlPatterns = { "/user" })
public class UserController extends HttpServlet {

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
            out.println("<title>Servlet UserController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserController at " + request.getContextPath() + "</h1>");
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
        UserDao dao = new UserDao();
        String action = request.getParameter("action");
        String section = request.getParameter("section");

        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "list":
                request.setAttribute("action", action);
                request.setAttribute("section", section);
                List<User> users = dao.getAllUser();
                request.setAttribute("users", users);
                request.getRequestDispatcher("Admin.jsp").forward(request, response); // hoặc /admin/user.jsp nếu cần
                break;
            case "create":
                request.setAttribute("action", action);
                request.getRequestDispatcher("create-user.jsp").forward(request, response);
                break;
            case "update":
                String idRaw = request.getParameter("id");
                int id = 0;
                try {
                    id = Integer.parseInt(idRaw);
                    User user = dao.getUserById(id);
                    request.setAttribute("user", user);

                    request.getRequestDispatcher("update-user.jsp").forward(request, response);

                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

                break;

            case "delete":
                String deleteIdRaw = request.getParameter("id");
                try {
                    id = Integer.parseInt(deleteIdRaw);
                    User user = dao.getUserById(id);
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("delete-user.jsp").forward(request, response);
                } catch (Exception e) {
                    request.setAttribute("errorMsg", "Invalid user ID.");
                }
                // // After deletion, reload the user list
                // request.setAttribute("action", "list");
                // List<User> updatedUsers = dao.getAllUser();
                // request.setAttribute("users", updatedUsers);
                // request.getRequestDispatcher("Admin.jsp").forward(request, response);
                break;
            default:
                throw new AssertionError();
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
        String action = request.getParameter("action");
        UserDao dao = new UserDao();
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                // Handle user creation
                try {
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String confirmPassword = request.getParameter("confirmPassword");
                    String fullname = request.getParameter("fullname");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phone");
                    String address = request.getParameter("address");
                    int role = Integer.parseInt(request.getParameter("role"));
                    int gender = Integer.parseInt(request.getParameter("gender"));

                    // Validate required fields
                    if (username == null || username.trim().isEmpty() ||
                        password == null || password.trim().isEmpty() ||
                        fullname == null || fullname.trim().isEmpty() ||
                        email == null || email.trim().isEmpty() ||
                        phone == null || phone.trim().isEmpty() ||
                        address == null || address.trim().isEmpty()) {
                        
                        request.setAttribute("errorMsg", "All fields are required.");
                        request.getRequestDispatcher("create-user.jsp").forward(request, response);
                        return;
                    }

                    // Validate password confirmation
                    if (!password.equals(confirmPassword)) {
                        request.setAttribute("errorMsg", "Passwords do not match.");
                        request.getRequestDispatcher("create-user.jsp").forward(request, response);
                        return;
                    }

                    // Validate password strength
                    if (password.length() < 6) {
                        request.setAttribute("errorMsg", "Password must be at least 6 characters long.");
                        request.getRequestDispatcher("create-user.jsp").forward(request, response);
                        return;
                    }

                    // Check if username already exists
                    if (dao.isUsernameExists(username)) {
                        request.setAttribute("errorMsg", "Username already exists. Please choose a different username.");
                        request.getRequestDispatcher("create-user.jsp").forward(request, response);
                        return;
                    }

                    // Check if email already exists
                    if (dao.isEmailExists(email)) {
                        request.setAttribute("errorMsg", "Email already exists. Please use a different email address.");
                        request.getRequestDispatcher("create-user.jsp").forward(request, response);
                        return;
                    }

                    // Create the user
                    boolean created = dao.createUser(username, password, fullname, email, phone, address, gender, role);
                    
                    if (created) {
                        // Success - redirect with success message
                        response.sendRedirect("user?action=list&section=User_List&successMsg=User created successfully");
                    } else {
                        // Failed to create user
                        request.setAttribute("errorMsg", "Failed to create user. Please try again.");
                        request.getRequestDispatcher("create-user.jsp").forward(request, response);
                    }
                    
                } catch (Exception e) {
                    request.setAttribute("errorMsg", "Error creating user: " + e.getMessage());
                    request.getRequestDispatcher("create-user.jsp").forward(request, response);
                }
                break;
            case "update":
                int userId = Integer.parseInt(request.getParameter("userId"));
                String username = request.getParameter("username");
                String fullname = request.getParameter("fullname");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                int role = Integer.parseInt(request.getParameter("role"));
                int gender = Integer.parseInt(request.getParameter("gender"));

                boolean update = dao.updateUser(userId, username, fullname, email, phone, address, role, gender);
                if (!update) {
                    request.setAttribute("errorMsg", "Failed to update user. Please check the input and try again.");
                    request.getRequestDispatcher("update-user.jsp").forward(request, response);
                    return;
                }
                // Redirect back to admin page with user list section
                response.sendRedirect("user?action=list&section=User_List");
                break;
            case "delete":
                String deleteIdRaw = request.getParameter("id");
                try {
                    int deleteId = Integer.parseInt(deleteIdRaw);
                    boolean deleted = dao.deleteUser(deleteId);
                    if (deleted) {
                        // Success - redirect with success message
                        response.sendRedirect("user?action=list&section=User_List&successMsg=User deleted successfully");
                    } else {
                        // Failed to delete - redirect with error message
                        response.sendRedirect("user?action=list&section=User_List&errorMsg=Failed to delete user. User may not exist or have associated data.");
                    }
                } catch (Exception e) {
                    // Error occurred - redirect with error message
                    response.sendRedirect("user?action=list&section=User_List&errorMsg=Error deleting user: " + e.getMessage());
                }
                break;

            default:
                throw new AssertionError();
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
