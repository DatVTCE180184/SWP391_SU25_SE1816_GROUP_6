package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import dao.AdminDAO;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String section = request.getParameter("section");
        if (section == null) section = "Dashboard";

        // Tạo đối tượng Product với dữ liệu mẫu
        Product product = new Product(1, 1, "Huawei Watch Fit 4", "Smartwatch", "img/huawei.jpg", 2790000, 50, 1);
        request.setAttribute("productInfo", AdminDAO.formatProductInfo(product));
        request.setAttribute("section", section);

        request.getRequestDispatcher("/Admin.jsp").forward(request, response);
    }
}