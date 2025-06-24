/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import utils.DBContext;
import model.Product;

/**
 *
 * @author ADMIN
 */
public class ProductDao extends DBContext {

    public List<Product> getAllProduct() {
        List<Product> listProduct = new ArrayList<>();
        String sql = "SELECT \n"
                + "	p.Product_ID, p.Category_ID,\n"
                + "	p.Product_Name, p.Product_Description,\n"
                + "	p.Product_Image, p.Product_Price,\n"
                + "	p.Product_Quantity, p.Product_Status\n"
                + "FROM \n"
                + "	Product p";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"), rs.getInt("Category_ID"),
                        rs.getString("Product_Name"), rs.getString("Product_Description"),
                        rs.getString("Product_Image"), rs.getDouble("Product_Price"),
                        rs.getInt("Product_Quantity"), rs.getInt("Product_Status"));
                listProduct.add(product);
            }

        } catch (SQLException e) {
            System.out.println("Error");
        }
        return listProduct;
    }

    public List<Product> getProductByCategory(String catID) {
        List<Product> listProduct_By_Category = new ArrayList<>();
//        String sql = "SELECT \n"
//                + "	p.Product_ID, p.Category_ID,\n"
//                + "	p.Product_Name, p.Product_Description,\n"
//                + "	p.Product_Image, p.Product_Price,\n"
//                + "	p.Product_Quantity, p.Product_Status\n"
//                + "FROM \n"
//                + "	Product p";

        String sql = " SELECT * FROM Product WHERE Category_ID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, catID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"), rs.getInt("Category_ID"),
                        rs.getString("Product_Name"), rs.getString("Product_Description"),
                        rs.getString("Product_Image"), rs.getDouble("Product_Price"),
                        rs.getInt("Product_Quantity"), rs.getInt("Product_Status"));
                listProduct_By_Category.add(product);
            }

        } catch (SQLException e) {
            System.out.println("Error");
        }
        return listProduct_By_Category;
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM Product WHERE Product_ID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                        rs.getInt("Product_ID"),
                        rs.getInt("Category_ID"),
                        rs.getString("Product_Name"),
                        rs.getString("Product_Description"),
                        rs.getString("Product_Image"),
                        rs.getDouble("Product_Price"),
                        rs.getInt("Product_Quantity"),
                        rs.getInt("Product_Status")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error");
        }
        return null;
    }

    public List<Product> searchProductByKeyword(String keyword) {
    List<Product> searchResults = new ArrayList<>();
    String sql = "SELECT * FROM Product WHERE Product_Name LIKE ? OR Product_Description LIKE ?";
    try {
        PreparedStatement ps = conn.prepareStatement(sql);
        String searchPattern = "%" + keyword + "%";
        ps.setString(1, searchPattern);
        ps.setString(2, searchPattern);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Product product = new Product(
                rs.getInt("Product_ID"),
                rs.getInt("Category_ID"),
                rs.getString("Product_Name"),
                rs.getString("Product_Description"),
                rs.getString("Product_Image"),
                rs.getDouble("Product_Price"),
                rs.getInt("Product_Quantity"),
                rs.getInt("Product_Status")
            );
            searchResults.add(product);
        }
    } catch (SQLException e) {
        System.out.println("Error");
    }
    return searchResults;
    }

    public static void main(String[] args) {
        ProductDao dao = new ProductDao();
        for (Product p : dao.searchProductByKeyword("iphone")) {
            System.out.println(p.toString());
        }
    }
}
