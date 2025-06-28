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
            request.setAttribute("list_Product_by_Category", proDao.getProductByCategory(CatID));
            request.getRequestDispatcher("Product_by_Category.jsp").forward(request, response);
            return;
        } 
        
        if ("details".equals(action)) {
            String String_id = request.getParameter("id");
            int id = Integer.parseInt(String_id);
            Product product = proDao.getProductById(id);
            request.setAttribute("product", product);
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
        processRequest(request, response);
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
