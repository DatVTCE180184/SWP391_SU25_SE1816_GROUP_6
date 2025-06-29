/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.CartItem;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

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
            out.println("<title>Servlet CartController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartController at " + request.getContextPath() + "</h1>");
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
        if (user == null || user.getRole_ID() == 0) {
            session.setAttribute("redirectAfterLogin", "cart");
            response.sendRedirect("signin?action=signin");
            return;
        }
        request.getRequestDispatcher("Cart.jsp").forward(request, response);
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
//        if (user == null || user.getRole_ID() == 0) {
//            response.sendRedirect("signin?action=signin");
//            return;
//        }

        ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        
        String action = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("id"));

        switch (action) {
            case "add": {
                String name = request.getParameter("name");
                String image = request.getParameter("image");
                double price = Double.parseDouble(request.getParameter("price"));
                int quantity = 1;
                boolean found = false;
                for (CartItem item : cart) {
                    if (item.getId() == id) {
                        item.setQuantity(item.getQuantity() + quantity);
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    cart.add(new CartItem(id, name, image, quantity, price));
                }

                // ✅ Sau khi thêm, quay lại trang trước
                session.setAttribute("cart", cart);
                String referer = request.getHeader("referer");
                response.sendRedirect(referer != null ? referer : "home");
                return;
            }

            case "increase": {
                for (CartItem item : cart) {
                    if (item.getId() == id) {
                        item.setQuantity(item.getQuantity() + 1);
                        break;
                    }
                }
                break;
            }

            case "decrease": {
                for (CartItem item : cart) {
                    if (item.getId() == id && item.getQuantity() > 1) {
                        item.setQuantity(item.getQuantity() - 1);
                        break;
                    }
                }
                break;
            }

            case "remove": {
                for (int i = 0; i < cart.size(); i++) {
                    if (cart.get(i).getId() == id) {
                        cart.remove(i);
                        break;
                    }
                }

            }
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("cart"); // Chỉ redirect đến cart nếu không phải hành động "add"
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
