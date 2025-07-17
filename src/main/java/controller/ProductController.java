/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDao;
import dao.ProductDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.Product;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ProductController", urlPatterns = {"/product"})
public class ProductController extends HttpServlet {

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
            out.println("<title>Servlet ProductController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductController at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        String CatID = request.getParameter("cat_ID");

        
        // --- BẮT ĐẦU: Xử lý cho admin quản lý sản phẩm ---
        String section = request.getParameter("section");
        request.setAttribute("section", section);
        jakarta.servlet.http.HttpSession session = request.getSession(false);
        model.User user = (session != null) ? (model.User) session.getAttribute("user") : null;
        if (action != null && (action.equals("admin") || action.equals("addForm") || action.equals("editForm") || action.equals("delete") || action.equals("toggleStatus"))) {
            if (user == null || user.getRole_ID() != 1) {
                response.sendRedirect("SignIn.jsp");
                return;
            }
            ProductDao proDao = new ProductDao();
            CategoryDao catDao = new CategoryDao();
            if ("admin".equals(action)) {
                String keyword = request.getParameter("keyword");
                String filterCatId = request.getParameter("cat_ID");
                String filterStatus = request.getParameter("status");
                if ((keyword != null && !keyword.isEmpty()) || (filterCatId != null && !filterCatId.isEmpty()) || (filterStatus != null && !filterStatus.isEmpty())) {
                    request.setAttribute("list_Product", proDao.searchAndFilterProducts(keyword, filterCatId, filterStatus));
                } else {
                    request.setAttribute("list_Product", proDao.getAllProduct());
                }
                request.setAttribute("list_Category", catDao.getAllCategory());
                request.getRequestDispatcher("Admin.jsp").forward(request, response);
                return;
            }
            if ("addForm".equals(action)) {
                request.setAttribute("list_Category", catDao.getAllCategory());
                request.getRequestDispatcher("AddProduct.jsp").forward(request, response);
                return;
            }
            if ("editForm".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Product product = proDao.getProductById(id);
                request.setAttribute("product", product);
                request.setAttribute("list_Category", catDao.getAllCategory());
                request.getRequestDispatcher("EditProduct.jsp").forward(request, response);
                return;
            }
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                proDao.deleteProduct(id);
                response.sendRedirect("product?action=admin");
                return;
            }
            if ("toggleStatus".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                proDao.updateProductStatus(id, !status);
                response.sendRedirect("product?action=admin");
                return;
            }
        }
        // --- KẾT THÚC: Xử lý cho admin quản lý sản phẩm ---

        
        if (action == null) {
            action = "list";
            request.setAttribute("action", action);
        }

        ProductDao proDao = new ProductDao();
        CategoryDao catDao = new CategoryDao();

        if ("list".equals(action) && (CatID == null || CatID.isEmpty())) {

            request.setAttribute("list_Product", proDao.getAllProduct());
            request.setAttribute("list_Category", catDao.getAllCategory());
            request.getRequestDispatcher("home").forward(request, response);
            return;
        } else if (action.equals("list") && CatID != null) {
            request.setAttribute("keyword", catDao.getCategoryByID(CatID).getCat_Name());
            request.setAttribute("products", proDao.getProductByCategory(CatID));
            request.getRequestDispatcher("Product_by_Category.jsp").forward(request, response);
            return;
        } 
        
        if ("details".equals(action)) {
             String String_id = request.getParameter("id");
            int id = Integer.parseInt(String_id);
            Product product = proDao.getProductById(id);
            // Lấy groupList (thông số kỹ thuật)
            int categoryId = product.getCat_ID();
            java.util.List<model.GroupSpecDTO> groupList = proDao.getGroupedSpecsByProductId(id, categoryId);
            request.setAttribute("product", product);
            request.setAttribute("groupList", groupList); // <-- Truyền groupList sang JSP
            request.getRequestDispatcher("Product.jsp").forward(request, response);
            return;
        }
//        switch (action) {
//            case "list":
//                request.setAttribute("list_Product", proDao.getAllProduct());
//                request.setAttribute("list_Category", catDao.getAllCategory());
//                request.getRequestDispatcher("home").forward(request, response);
////                response.sendRedirect("HomePage.jsp");
//                break;
//        }

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
              String action = request.getParameter("action");
        jakarta.servlet.http.HttpSession session = request.getSession(false);
        model.User user = (session != null) ? (model.User) session.getAttribute("user") : null;
        if (action != null && (action.equals("add") || action.equals("edit"))) {
            if (user == null || user.getRole_ID() != 1) {
                response.sendRedirect("SignIn.jsp");
                return;
            }
            ProductDao proDao = new ProductDao();
            if ("add".equals(action)) {
                int catId = Integer.parseInt(request.getParameter("cat_ID"));
                String name = request.getParameter("pro_Name");
                String desc = request.getParameter("pro_Description");
                String img = request.getParameter("pro_Image");
                double price = Double.parseDouble(request.getParameter("pro_Price"));
                int quantity = Integer.parseInt(request.getParameter("pro_Quantity"));
                boolean status = "1".equals(request.getParameter("pro_Status"));
                String colors = request.getParameter("pro_Colors");
                String specs = request.getParameter("pro_Specs");
                String detailImg = request.getParameter("pro_Detail_Image");
                Product p = new Product(-1, catId, name, desc, img, price, quantity, status ? 1 : 0, colors, detailImg, null);
                proDao.addProduct(p);
                response.sendRedirect("product?action=admin");
                return;
            }
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("pro_ID"));
                int catId = Integer.parseInt(request.getParameter("cat_ID"));
                String name = request.getParameter("pro_Name");
                String desc = request.getParameter("pro_Description");
                String img = request.getParameter("pro_Image");
                double price = Double.parseDouble(request.getParameter("pro_Price"));
                int quantity = Integer.parseInt(request.getParameter("pro_Quantity"));
                boolean status = "1".equals(request.getParameter("pro_Status"));
                String colors = request.getParameter("pro_Colors");
                String specs = request.getParameter("pro_Specs");
                String detailImg = request.getParameter("pro_Detail_Image");
               Product p = new Product(id, catId, name, desc, img, price, quantity, status ? 1 : 0, colors, detailImg, null);
                proDao.updateProduct(p);
                response.sendRedirect("product?action=admin");
                return;
            }
        } else {
            processRequest(request, response);
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
