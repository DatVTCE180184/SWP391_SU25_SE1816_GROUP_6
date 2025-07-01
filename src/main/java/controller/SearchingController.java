/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Product;
import java.util.Collections;
import java.util.Comparator;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "SearchingController", urlPatterns = {"/search"})
public class SearchingController extends HttpServlet {

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
            out.println("<title>Servlet SearchingController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchingController at " + request.getContextPath() + "</h1>");
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
        String keyword = request.getParameter("keyword");
//        String sort = request.getParameter("sort");
//        String price = request.getParameter("price");

        ProductDao proDao = new ProductDao();
        String from = request.getParameter("from");
        List<Product> products = null;
        if (from.equals("Product_by_Category")) {
            products = proDao.searchProductByCateghoryName(keyword.trim());
                request.setAttribute("products", products);
        request.setAttribute("keyword", keyword);
        request.setAttribute("form", from);
        request.getRequestDispatcher("Product_by_Category.jsp").forward(request, response);
        } else if (from.equals("SearchFilter")) {
            products = proDao.searchProductByKeyword(keyword.trim());
                request.setAttribute("products", products);
        request.setAttribute("keyword", keyword);
        request.setAttribute("form", from);
        request.getRequestDispatcher("SearchFilter.jsp").forward(request, response);
        }
        
//          request.setAttribute("products", products);
//        request.setAttribute("keyword", keyword);
//        request.setAttribute("form", from);
//        request.getRequestDispatcher("SearchFilter.jsp").forward(request, response);
        
//        // Lọc theo giá nếu có
//        if (price != null && !price.isEmpty()) {
//            try {
//                String[] range = price.split("-");
//                double min = Double.parseDouble(range[0]);
//                double max = Double.parseDouble(range[1]);
//                for (int i = products.size() - 1; i >= 0; i--) {
//                    double p = products.get(i).getPro_Price();
//                    if (p < min || p > max) {
//                        products.remove(i);
//                    }
//                }
//            } catch (Exception e) {
//                // ignore
//            }
//        }
//        // Sắp xếp theo lựa chọn
//        if (sort != null && !sort.isEmpty()) {
//            if ("price_asc".equals(sort)) {
//                Collections.sort(products, new Comparator<Product>() {
//                    public int compare(Product a, Product b) {
//                        return Double.compare(a.getPro_Price(), b.getPro_Price());
//                    }
//                });
//            } else if ("price_desc".equals(sort)) {
//                Collections.sort(products, new Comparator<Product>() {
//                    public int compare(Product a, Product b) {
//                        return Double.compare(b.getPro_Price(), a.getPro_Price());
//                    }
//                });
//            } else if ("name_asc".equals(sort)) {
//                Collections.sort(products, new Comparator<Product>() {
//                    public int compare(Product a, Product b) {
//                        return a.getPro_Name().compareToIgnoreCase(b.getPro_Name());
//                    }
//                });
//            } else if ("name_desc".equals(sort)) {
//                Collections.sort(products, new Comparator<Product>() {
//                    public int compare(Product a, Product b) {
//                        return b.getPro_Name().compareToIgnoreCase(a.getPro_Name());
//                    }
//                });
//            } else if ("id_desc".equals(sort)) {
//                Collections.sort(products, new Comparator<Product>() {
//                    public int compare(Product a, Product b) {
//                        return b.getPro_ID() - a.getPro_ID();
//                    }
//                });
//            } else if ("id_asc".equals(sort)) {
//                Collections.sort(products, new Comparator<Product>() {
//                    public int compare(Product a, Product b) {
//                        return a.getPro_ID() - b.getPro_ID();
//                    }
//                });
//            }
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
        HttpSession session = request.getSession();
        String keyword = request.getParameter("keyword");
        String from = request.getParameter("from");

        String sort = request.getParameter("sort");
        String price = request.getParameter("price");
        ProductDao proDao = new ProductDao();

        List<Product> products = null;
        if (from.equals("Product_by_Category")) {
            products = proDao.searchProductByCateghoryName(keyword.trim());
        } else if (from.equals("SearchFilter")) {
            products = proDao.searchProductByKeyword(keyword.trim());
        }

        // Lọc theo giá nếu có
        if (price != null && !price.isEmpty()) {
            try {
                String[] range = price.split("-");
                double min = Double.parseDouble(range[0]);
                double max = Double.parseDouble(range[1]);
                for (int i = products.size() - 1; i >= 0; i--) {
                    double p = products.get(i).getPro_Price();
                    if (p < min || p > max) {
                        products.remove(i);
                    }
                }
            } catch (Exception e) {
                // ignore
            }
        }
        // Sắp xếp theo lựa chọn
        if (sort != null && !sort.isEmpty()) {
            if ("price_asc".equals(sort)) {
                Collections.sort(products, new Comparator<Product>() {
                    public int compare(Product a, Product b) {
                        return Double.compare(a.getPro_Price(), b.getPro_Price());
                    }
                });
            } else if ("price_desc".equals(sort)) {
                Collections.sort(products, new Comparator<Product>() {
                    public int compare(Product a, Product b) {
                        return Double.compare(b.getPro_Price(), a.getPro_Price());
                    }
                });
            } else if ("name_asc".equals(sort)) {
                Collections.sort(products, new Comparator<Product>() {
                    public int compare(Product a, Product b) {
                        return a.getPro_Name().compareToIgnoreCase(b.getPro_Name());
                    }
                });
            } else if ("name_desc".equals(sort)) {
                Collections.sort(products, new Comparator<Product>() {
                    public int compare(Product a, Product b) {
                        return b.getPro_Name().compareToIgnoreCase(a.getPro_Name());
                    }
                });
            } else if ("id_desc".equals(sort)) {
                Collections.sort(products, new Comparator<Product>() {
                    public int compare(Product a, Product b) {
                        return b.getPro_ID() - a.getPro_ID();
                    }
                });
            } else if ("id_asc".equals(sort)) {
                Collections.sort(products, new Comparator<Product>() {
                    public int compare(Product a, Product b) {
                        return a.getPro_ID() - b.getPro_ID();
                    }
                });
            }
        }
        request.setAttribute("products", products);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("Product_by_Category.jsp").forward(request, response);
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
