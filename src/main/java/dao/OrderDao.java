/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import model.CartItem;
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
            ps.setString(6, Payment_Method);
            int rs1 = ps.executeUpdate();
            if (rs1 == 0) {
                throw new Exception("Không thể tạo đơn hàng mới.");
            }

            // Lấy Order_ID được sinh ra
            ResultSet rs = ps.getGeneratedKeys();
            int orderId = -1;
            if (rs.next()) {
                orderId = rs.getInt(1);
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

    public static void main(String[] args) {
        OrderDao orDao = new OrderDao();

    }
}
