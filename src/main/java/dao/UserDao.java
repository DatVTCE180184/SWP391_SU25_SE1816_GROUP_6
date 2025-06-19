/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.security.MessageDigest;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBContext;
import model.User;

/**
 *
 * @author ADMIN
 */
public class UserDao extends DBContext {

    public UserDao() {
        super();
    }

    // Hash mật khẩu MD5
    public String hashMD5(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] bytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    // Đăng nhập - xác thực username và password
    public User signIn(String username, String password) {
        String sql = "SELECT * FROM Users WHERE Username = ? AND Password = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setID(rs.getInt("User_ID"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setGender(rs.getInt("Gender_ID"));
                user.setAvatar(rs.getString("Avatar"));
                user.setRole_ID(rs.getInt("Role_ID"));
//                user.setCreatedAt(rs.getString("Created_At"));
//                user.setUpdatedAt(rs.getString("Updated_At"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Login error: " + e.getMessage());
        }
        return null;
    }

    public List<User> getAllUser() {
        List<User> listUser = new ArrayList<>();
        String sql = "SELECT	U.User_ID, U.Username, U.Password,\n"
                + "		U.Email, U.Phone, U.Address,\n"
                + "		G.Gender_ID, U.Avatar,  R.Role_ID,\n"
                + "		U.Created_At, U.Updated_At\n"
                + "FROM Users U \n"
                + "JOIN  Gender G ON U.Gender_ID = G.Gender_ID \n"
                + "JOIN  Role R ON U.Role_ID = R.Role_ID;";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User(rs.getInt("User_ID"), rs.getString("Username"),
                        rs.getString("Password"), rs.getString("Email"),
                        rs.getString("Phone"), rs.getString("Address"),
                        rs.getInt("Gender_ID"), rs.getString("Avatar"), rs.getInt("Role_ID"));
                listUser.add(user);
            }

        } catch (SQLException e) {
        }
        return listUser;
    }
    
     // ForgotPassword: Lấy user theo email
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE Email = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setID(rs.getInt("User_ID"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setGender(rs.getInt("Gender_ID"));
                user.setAvatar(rs.getString("Avatar"));
                user.setRole_ID(rs.getInt("Role_ID"));
//                user.setCreatedAt(rs.getString("Created_At"));
//                user.setUpdatedAt(rs.getString("Updated_At"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
    // ForgotPassword: Cập nhật mật khẩu theo email
    public boolean updatePasswordByEmail(String email, String newPassword) {
        String sql = "UPDATE Users SET Password = ? WHERE Email = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, hashMD5(newPassword));
            ps.setString(2, email);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
        public boolean register(User user) {
        System.out.println("Starting registration for user: " + user.getUsername());
        
        if (isUsernameExist(user.getUsername()) || isEmailExist(user.getEmail()) || isPhoneExist(user.getPhone())) {
            System.out.println("User already exists - Username: " + isUsernameExist(user.getUsername()) + 
                              ", Email: " + isEmailExist(user.getEmail()) + 
                              ", Phone: " + isPhoneExist(user.getPhone()));
            return false;
        }

        String sql = "INSERT INTO Users (Username, Password, Email, Phone, Address, Gender_ID, Avatar, Role_ID) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, hashMD5(user.getPassword()));
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setInt(6, user.getGender());
            ps.setString(7, user.getAvatar());
            ps.setInt(8, user.getRole_ID()); // thường mặc định là 3 = Customer
            
            int result = ps.executeUpdate();
            System.out.println("Registration result: " + result);
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Registration SQL error: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Registration general error: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

        
    // Kiểm tra username đã tồn tại chưa
    public boolean isUsernameExist(String username) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Username = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra email đã tồn tại chưa
    public boolean isEmailExist(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Email = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra phone đã tồn tại chưa
    public boolean isPhoneExist(String phone) {
        String sql = "SELECT COUNT(*) FROM Users WHERE Phone = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        UserDao dao = new UserDao();
        System.out.println(dao.signIn("admin01", "admin123").toString());

        for (User u : dao.getAllUser()) {
            System.out.println(u.toString());
        }
    }
}
