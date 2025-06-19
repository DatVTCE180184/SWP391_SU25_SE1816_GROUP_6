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

/**
 *
 * @author ADMIN
 */
public class CategoryDao extends DBContext {

    public CategoryDao() {
        super();
    }

    public List<Category> getAllCategory() {
        List<Category> listCat = new ArrayList<>();
        String sql = "SELECT  \n"
                + "	c.Category_ID, c.Category_Name,\n"
                + "	c.Category_Description, c.Category_Image,\n"
                + "	c.Category_Parent_ID, c.Category_Status\n"
                + "FROM \n"
                + "	Category c";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category cat = new Category(rs.getInt("Category_ID"), rs.getString("Category_Name"), 
                                            rs.getString("Category_Description"), rs.getInt("Category_Parent_ID"),
                                            rs.getString("Category_Image"), rs.getInt("Category_Status"));
                listCat.add(cat);
            }

        } catch (SQLException e) {
            System.out.println("Error");
        }
        return listCat;
    }
    
    public static void main(String[] args) {
        CategoryDao dao = new CategoryDao();
        for (Category cat : dao.getAllCategory()) {
            System.out.println(cat.toString());
        }
        
        
    }
}
