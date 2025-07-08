/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.CartItem;
import model.Order;
import model.User;
import utils.DBContext;

/**
 *
 * @author ADMIN
 */
public class OrderDao extends DBContext {

    public OrderDao() {
        super();
    }

    public int createOrder(List<CartItem> cart, String userID, String fullName,
            String phone, String note, String Payment_Method, String address) {
        try {

            // 1. Insert vào bảng Orders
            String sql = "INSERT INTO Orders (User_ID, Shipping_Address, Order_Phone, Note, Total_Amount, Payment_Method, Status)\n"
                    + "VALUES (?, ?, ?, ?, ?, ?, 'Processing');";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userID);
            ps.setString(2, address);
            ps.setString(3, phone);
            ps.setString(4, note);
            ps.setDouble(5, countAmout(cart));
            ps.setString(6, Payment_Method.toUpperCase());
            int rs1 = ps.executeUpdate();
            if (rs1 == 0) {
                throw new Exception("Không thể tạo đơn hàng mới.");
            }
            // Lấy Order_ID được sinh ra

            int orderId = -1;

            // Nếu không lấy được từ getGeneratedKeys, thử lấy ID lớn nhất từ bảng Orders
            String getIdSql = "SELECT MAX(Order_ID) FROM Orders";
            PreparedStatement getIdPs = conn.prepareStatement(getIdSql);
            ResultSet idRs = getIdPs.executeQuery();
            if (idRs.next()) {
                orderId = idRs.getInt(1);
            } else {
                throw new Exception("Không lấy được Order_ID mới.");
            }

            // 2. Insert vào Order_Details
            for (CartItem item : cart) {
                if (addOrderDetail(orderId, item) != 1) {
                    throw new Exception("Không thể thêm chi tiết đơn hàng cho sản phẩm ID: " + item.getId());
                }
            }
            return (rs1 > 0) ? 1 : 0;
        } catch (Exception e) {
            try {
                if (conn != null) {
                    conn.rollback(); // Rollback nếu có lỗi
                    System.err.println("Rollback do lỗi: " + e.getMessage());
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return 0;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true); // Khôi phục lại trạng thái auto-commit ban đầu
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
                return 0;
            }
        }

    }

    private int addOrderDetail(int orderID, CartItem item) {
        // 2. Insert vào Order_Details
        String sql1 = "INSERT INTO Order_Detail (Order_ID, Product_ID, Price, Quantity)\n"
                + "VALUES (?, ?, ?, ?);";
        try {

            PreparedStatement ps = conn.prepareStatement(sql1);

            ps.setInt(1, orderID);
            ps.setInt(2, item.getId());
            ps.setDouble(3, item.getPrice());
            ps.setInt(4, item.getQuantity());
            int rs = ps.executeUpdate();
            return (rs > 0) ? 1 : 0;
        } catch (Exception e) {
            System.err.println("Insert error");
            return 0;
        }

    }

    private double countAmout(List<CartItem> cart) {
        // Tính tổng tiền
        double totalAmount = 0;
        for (CartItem item : cart) {
            totalAmount += item.getPrice() * item.getQuantity();
        }

        return totalAmount;
    }
    
//    
//    // Tính tổng tiền
//    private double countAmout(List<CartItem> cart) {
//        double totalAmount = 0;
//        for (CartItem item : cart) {
//            totalAmount += item.getPrice() * item.getQuantity();
//        }
//        return totalAmount;
//    }

    // Thống kê số lượng đơn hàng theo trạng thái
    public Map<String, Integer> getOrderStatusStats() {
        Map<String, Integer> stats = new HashMap<>();
        String sql = "SELECT Status, COUNT(*) FROM Orders GROUP BY Status";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                stats.put(rs.getString(1), rs.getInt(2));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }
    
    
    // Top sản phẩm bán chạy nhất
    public List<Map<String, Object>> getTopSellingProducts(int topN) {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT p.Product_Name, SUM(od.Quantity) as totalSold " +
                     "FROM Order_Detail od JOIN Product p ON od.Product_ID = p.Product_ID " +
                     "GROUP BY p.Product_Name ORDER BY totalSold DESC LIMIT ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, topN);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("name", rs.getString(1));
                row.put("sold", rs.getInt(2));
                result.add(row);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    
    // Doanh thu theo tháng gần nhất
    public Map<String, Double> getMonthlyRevenue(int months) {
        Map<String, Double> revenue = new LinkedHashMap<>();
        String sql = "SELECT DATE_FORMAT(Created_At, '%Y-%m') as month, SUM(Total_Amount) " +
                     "FROM Orders GROUP BY month ORDER BY month DESC LIMIT ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, months);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                revenue.put(rs.getString(1), rs.getDouble(2));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return revenue;
    }

    
    // Lấy tất cả đơn hàng
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders ORDER BY Created_At DESC";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setOrder_ID(rs.getInt("Order_ID"));
                o.setUser_ID(rs.getInt("User_ID"));
                o.setShipping_Address(rs.getString("Shipping_Address"));
                o.setOrder_Phone(rs.getString("Order_Phone"));
                o.setNote(rs.getString("Note"));
                o.setTotal_Amout(rs.getDouble("Total_Amount"));
                o.setPayment_Method(rs.getString("Payment_Method"));
                o.setOrder_Status(rs.getString("Status"));
//                o.setCreated_At(rs.getTimestamp("Created_At"));
                list.add(o);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }


    
    // Cập nhật trạng thái đơn hàng
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE Orders SET Status = ? WHERE Order_ID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
    
    
    
    // Xóa đơn hàng
    public boolean deleteOrder(int orderId) {
        String sql = "DELETE FROM Orders WHERE Order_ID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
    // Class to hold total revenue and total orders
    public static class RevenueStats {
        private final double totalRevenue;
        private final int totalOrders;

        public RevenueStats(double totalRevenue, int totalOrders) {
            this.totalRevenue = totalRevenue;
            this.totalOrders = totalOrders;
        }

        public double getTotalRevenue() {
            return totalRevenue;
        }

        public int getTotalOrders() {
            return totalOrders;
        }
    }

    public RevenueStats getTotalRevenueAndOrders() {
        double totalRevenue = 0;
        int totalOrders = 0;
        String sql = "SELECT COUNT(*), COALESCE(SUM(Total_Amount),0) FROM Orders";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                totalOrders = rs.getInt(1);
                totalRevenue = rs.getDouble(2);
            }
            return new RevenueStats(totalRevenue, totalOrders);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new RevenueStats(0, 0);
    }


    public static void main(String[] args) {
        OrderDao orDao = new OrderDao();

        // Tạo giỏ hàng
        List<CartItem> cart = new ArrayList<>();
        CartItem item1 = new CartItem();
        item1.setId(1);  // iPhone 15
        item1.setName("iPhone 15");
        item1.setPrice(25000000);
        item1.setQuantity(1);
        cart.add(item1);

        CartItem item2 = new CartItem();
        item2.setId(3);  // Xiaomi
        item2.setName("Xiaomi Note 13");
        item2.setPrice(7000000);
        item2.setQuantity(2);
        cart.add(item2);

        // Gọi hàm tạo đơn
        int result = orDao.createOrder(
                cart,
                "1", // userID (từ bảng Users)
                "Nguyễn Văn A",
                "0912345678",
                "Giao nhanh giúp mình",
                "InStore", // hoặc "COD"
                "Nhận tại cửa hàng" // address
        );

        if (result == 1) {
            System.out.println("Đặt hàng thành công!");
        } else {
            System.out.println("Đặt hàng thất bại!");
        }

    }
}
