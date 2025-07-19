package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Review;
import utils.DBContext;

public class ReviewDao extends DBContext {

    public List<Review> getAllReviews() {
        List<Review> list = new ArrayList<>();
       String sql = "SELECT Review_ID, User_ID, Product_ID, Order_ID, Rating, Comment, Review_Date " +
             "FROM Product_Review";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Review review = new Review();
                review.setReview_ID(rs.getInt("Review_ID"));
                review.setUser_ID(rs.getInt("User_ID"));
                review.setProduct_ID(rs.getInt("Product_ID"));
                review.setOrder_ID(rs.getInt("Order_ID"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setReview_Date(rs.getTimestamp("Review_Date"));
            
                list.add(review);
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi truy vấn getAllReviews: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public void addReview(int userId, int productId, Integer orderId, int rating, String comment) {
        String sql = "INSERT INTO Product_Review (User_ID, Product_ID, Order_ID, Rating, Comment) VALUES (?, ?, ?, ?, ?)";
        try {
            System.out.println("DEBUG: SQL = " + sql);
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            if (orderId != null) {
                ps.setInt(3, orderId);
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            ps.setInt(4, rating);
            ps.setString(5, comment);
            int rows = ps.executeUpdate();
            System.out.println("DEBUG: Rows inserted = " + rows);
        } catch (Exception e) {
            System.out.println("Lỗi khi thêm review: " + e.getMessage());
            e.printStackTrace();
        } 
    }

    public void updateReview(int reviewId, int rating, String comment) {
        String sql = "UPDATE Product_Review SET Rating=?, Comment=? WHERE Review_ID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, rating);
            ps.setString(2, comment);
            ps.setInt(3, reviewId);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Lỗi khi cập nhật review: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void deleteReview(int reviewId) {
        String sql = "DELETE FROM Product_Review WHERE Review_ID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, reviewId);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Lỗi khi xóa review: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public List<Review> getReviewsByProductId(int productId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT Review_ID, User_ID, Product_ID, Order_ID, Rating, Comment, Review_Date FROM Product_Review WHERE Product_ID = ? ORDER BY Review_Date DESC";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Review review = new Review();
                review.setReview_ID(rs.getInt("Review_ID"));
                review.setUser_ID(rs.getInt("User_ID"));
                review.setProduct_ID(rs.getInt("Product_ID"));
                review.setOrder_ID(rs.getInt("Order_ID"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setReview_Date(rs.getTimestamp("Review_Date"));
                list.add(review);
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi truy vấn getReviewsByProductId: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        ReviewDao dao = new ReviewDao();
        List<Review> reviews = dao.getAllReviews();
        System.out.println("Số lượng review: " + reviews.size());
        for (Review r : reviews) {
            System.out.println(r);
        }
    }
}
