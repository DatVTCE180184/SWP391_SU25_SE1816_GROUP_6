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
import model.GroupSpecDTO;// mới them 12-7 de chia nhóm cho thông số kỹ thuật 
import model.ProductSpec;

/**
 *
 * @author ADMIN
 */
public class ProductDao extends DBContext {

    public List<Product> getAllProduct() {
        List<Product> listProduct = new ArrayList<>();
        String sql = "SELECT "
                + "p.Product_ID, p.Category_ID, p.Product_Name, p.Product_Description, "
                + "p.Product_Image, p.Product_Price, p.Product_Quantity, p.Product_Status, "
                + "p.Product_Colors, p.Product_Specs, p.Product_Detail_Image, "
                + "c.Category_Name as cat_Name "
                + "FROM Product p "
                + "JOIN Category c ON p.Category_ID = c.Category_ID";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"), rs.getInt("Category_ID"),
                        rs.getString("Product_Name"), rs.getString("Product_Description"),
                        rs.getString("Product_Image"), rs.getDouble("Product_Price"),
                        rs.getInt("Product_Quantity"), rs.getInt("Product_Status"),
                        rs.getString("Product_Colors"), rs.getString("Product_Detail_Image"),
                        rs.getString("cat_Name")
                );
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
                        rs.getInt("Product_Quantity"), rs.getInt("Product_Status"),
                        // mới thêm  chi tiết sản phẩm 
                       rs.getString("Product_Colors"), rs.getString("Product_Detail_Image"),
                        null // cat_Name
                );
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
                        rs.getInt("Product_Status"),
                        rs.getString("Product_Colors"),
                       // rs.getString("Product_Specs"),
                        // chi tiết sản phẩm 
                        rs.getString("Product_Detail_Image"),
                        null // cat_Name
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
                        rs.getInt("Product_Status"),
                        rs.getString("Product_Colors"),
                       // rs.getString("Product_Specs"),
                        // chi tiết sản phẩm 
                        rs.getString("Product_Detail_Image"),
                        null // cat_Name
                );
                searchResults.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Error");
        }
        return searchResults;
    }

    public List<Product> searchProductByCateghoryName(String keyword) {
        List<Product> searchResults = new ArrayList<>();
        String sql = "SELECT *\n"
                + "From Product p\n"
                + "JOIN Category c on c.Category_ID = p.Category_ID\n"
                + "WHERE c.Category_Name = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            String searchPattern = keyword;
            ps.setString(1, searchPattern);
//            ps.setString(2, searchPattern);
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
                        rs.getInt("Product_Status"),
                        rs.getString("Product_Colors"),
                        //rs.getString("Product_Specs"),
                        // chi tiết sản phẩm 
                        rs.getString("Product_Detail_Image"),
                        null // cat_Name
                );
                searchResults.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Error");
        }
        return searchResults;
    }

    // Thêm sản phẩm mới
    public boolean addProduct(Product p) {
        String sql = "INSERT INTO Product (Category_ID, Product_Name, Product_Description, Product_Image, Product_Price, Product_Quantity, Product_Status, Product_Colors, Product_Specs, Product_Detail_Image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, p.getCat_ID());
            ps.setString(2, p.getPro_Name());
            ps.setString(3, p.getPro_Description());
            ps.setString(4, p.getPro_Image());
            ps.setDouble(5, p.getPro_Price());
            ps.setInt(6, p.getPro_Quantity());
            ps.setInt(7, p.isPro_Status() ? 1 : 0);
            ps.setString(8, p.getPro_Colors());
            //ps.setString(9, p.getPro_Specs());
            ps.setString(10, p.getPro_Detail_Image());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Sửa sản phẩm
    public boolean updateProduct(Product p) {
        String sql = "UPDATE Product SET Category_ID=?, Product_Name=?, Product_Description=?, Product_Image=?, Product_Price=?, Product_Quantity=?, Product_Status=?, Product_Colors=?, Product_Detail_Image=? WHERE Product_ID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, p.getCat_ID());
            ps.setString(2, p.getPro_Name());
            ps.setString(3, p.getPro_Description());
            ps.setString(4, p.getPro_Image());
            ps.setDouble(5, p.getPro_Price());
            ps.setInt(6, p.getPro_Quantity());
            ps.setInt(7, p.isPro_Status() ? 1 : 0);
            ps.setString(8, p.getPro_Colors());
            ps.setString(9, p.getPro_Detail_Image());
            ps.setInt(10, p.getPro_ID());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Error");
        }
        return false;
    }

    // Xóa sản phẩm
    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM Product WHERE Product_ID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật trạng thái sản phẩm (ẩn/hiện)
    public boolean updateProductStatus(int id, boolean status) {
        String sql = "UPDATE Product SET Product_Status=? WHERE Product_ID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, status ? 1 : 0);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lọc sản phẩm theo tên, danh mục, trạng thái
    public List<Product> searchAndFilterProducts(String keyword, String catId, String status) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT p.Product_ID, p.Category_ID, p.Product_Name, p.Product_Description, p.Product_Image, p.Product_Price, p.Product_Quantity, p.Product_Status, p.Product_Colors, p.Product_Detail_Image, c.Category_Name as cat_Name FROM Product p JOIN Category c ON p.Category_ID = c.Category_ID WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND p.Product_Name LIKE ?");
            params.add("%" + keyword + "%");
        }
        if (catId != null && !catId.isEmpty()) {
            sql.append(" AND p.Category_ID = ?");
            params.add(catId);
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND p.Product_Status = ?");
            params.add(status);
        }
        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("Product_ID"), rs.getInt("Category_ID"),
                        rs.getString("Product_Name"), rs.getString("Product_Description"),
                        rs.getString("Product_Image"), rs.getDouble("Product_Price"),
                        rs.getInt("Product_Quantity"), rs.getInt("Product_Status"),
                        rs.getString("Product_Colors"), rs.getString("Product_Detail_Image"),
                        rs.getString("cat_Name")
                );
                list.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

// Thêm hàm lấy thông số kỹ thuật từ bảng Product_Spec (chuẩn hóa)
    public List<ProductSpec> getSpecsByProductId(int productId) {
        List<ProductSpec> specs = new ArrayList<>();
        String sql = "SELECT ps.Spec_ID, ps.Product_ID, st.Spec_Name, ps.Spec_Value "
                + "FROM Product_Spec ps "
                + "JOIN Spec_Type st ON ps.Spec_ID = st.Spec_ID "
                + "WHERE ps.Product_ID = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductSpec spec = new ProductSpec();
                spec.setSpecId(rs.getInt("Spec_ID"));
                spec.setProductId(rs.getInt("Product_ID"));
                spec.setSpecName(rs.getString("Spec_Name")); // Lấy từ Spec_Type
                spec.setSpecValue(rs.getString("Spec_Value"));
                specs.add(spec);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return specs;
    }
    // 11/7 lấy thông số kỹ thuật theo nhóm 

    public List<GroupSpecDTO> getGroupedSpecsByProductId(int productId, int categoryId) {
        List<GroupSpecDTO> groupList = new ArrayList<>();
        String groupSql = "SELECT Group_ID, Group_Name FROM Spec_Group WHERE Category_ID = ?";
        try ( PreparedStatement groupPs = conn.prepareStatement(groupSql)) {
            groupPs.setInt(1, categoryId);
            ResultSet groupRs = groupPs.executeQuery();
            while (groupRs.next()) {
                int groupId = groupRs.getInt("Group_ID");
                String groupName = groupRs.getString("Group_Name");

                // Lấy các thông số thuộc group này cho sản phẩm
                String specSql = "SELECT st.Spec_ID, st.Spec_Name, ps.Spec_Value "
                        + "FROM Spec_Type st "
                        + "LEFT JOIN Product_Spec ps ON st.Spec_ID = ps.Spec_ID AND ps.Product_ID = ? "
                        + "WHERE st.Group_ID = ? "
                        + "ORDER BY st.Spec_ID";
                try ( PreparedStatement specPs = conn.prepareStatement(specSql)) {
                    specPs.setInt(1, productId);
                    specPs.setInt(2, groupId);
                    ResultSet specRs = specPs.executeQuery();
                    List<ProductSpec> specList = new ArrayList<>();
                    while (specRs.next()) {
                        ProductSpec spec = new ProductSpec();
                        spec.setSpecId(specRs.getInt("Spec_ID"));
                        spec.setSpecName(specRs.getString("Spec_Name"));
                        spec.setSpecValue(specRs.getString("Spec_Value"));
                        specList.add(spec);
                    }
                    groupList.add(new model.GroupSpecDTO(groupId, groupName, specList));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return groupList;
    }

    public static void main(String[] args) {
        ProductDao dao = new ProductDao();
        for (GroupSpecDTO p : dao.getGroupedSpecsByProductId(3, 2)) {
            System.out.println(p.getSpecList());
        }
    }

}
