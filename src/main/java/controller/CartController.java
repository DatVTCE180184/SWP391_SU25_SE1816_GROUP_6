package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.CartItem;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    // 🟡 Hiển thị trang giỏ hàng (GET)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    // 🔵 Xử lý các hành động giỏ hàng (POST)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
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
}
