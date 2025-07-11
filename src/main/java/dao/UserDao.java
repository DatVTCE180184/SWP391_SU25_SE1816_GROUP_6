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
                user.setFullname(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setGender(rs.getInt("Gender_ID"));
                user.setAvatar(rs.getString("Avatar"));
                user.setRole_ID(rs.getInt("Role_ID"));
                // user.setCreatedAt(rs.getString("Created_At"));
                // user.setUpdatedAt(rs.getString("Updated_At"));
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
                + "		U.FullName, U.Email, U.Phone, U.Address,\n"
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
                        rs.getString("Password"), rs.getString("FullName"), rs.getString("Email"),
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
                user.setFullname(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setGender(rs.getInt("Gender_ID"));
                user.setAvatar(rs.getString("Avatar"));
                user.setRole_ID(rs.getInt("Role_ID"));
                // user.setCreatedAt(rs.getString("Created_At"));
                // user.setUpdatedAt(rs.getString("Updated_At"));
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
            System.out.println("User already exists - Username: " + isUsernameExist(user.getUsername())
                    + ", Email: " + isEmailExist(user.getEmail())
                    + ", Phone: " + isPhoneExist(user.getPhone()));
            return false;
        }

        String sql = "INSERT INTO Users (Username, Password, FullName, Email, Phone, Address, Gender_ID, Avatar, Role_ID) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, hashMD5(user.getPassword()));
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            ps.setInt(7, user.getGender());
            ps.setString(8, user.getAvatar());
            ps.setInt(9, user.getRole_ID()); // thường mặc định là 3 = Customer

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
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
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
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
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
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Check if username exists (alias for isUsernameExist)
    public boolean isUsernameExists(String username) {
        return isUsernameExist(username);
    }

    // Check if email exists (alias for isEmailExist)
    public boolean isEmailExists(String email) {
        return isEmailExist(email);
    }

    // Lấy thông tin user theo ID
    public User getUserById(int id) {
        String sql = "SELECT * FROM Users WHERE User_ID = ?";
        User user = new User();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                user.setID(rs.getInt("User_ID"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setFullname(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setGender(rs.getInt("Gender_ID"));
                user.setAvatar(rs.getString("Avatar"));
                user.setRole_ID(rs.getInt("Role_ID"));
                // user.setCreatedAt(rs.getString("Created_At"));
                // user.setUpdatedAt(rs.getString("Updated_At"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean updateUserProfile(User user) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from
        // nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void updatePasswordById(int id, String newPassword) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from
        // nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    /**
     * Update User Role to Staff or Admin
     *
     * @param userId
     * @param newRoleId
     * @return
     */
    public boolean updateUserRole(int userId, int newRoleId) {
        String sql = "UPDATE Users SET Role_ID = ? WHERE User_ID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, newRoleId);
            ps.setInt(2, userId);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ADMIN management
    // Create new user
    public boolean createUser(String username, String password, String fullname, String email,
            String phone, String address, int gender, int role) {
        String sql = "INSERT INTO Users (Username, Password, FullName, Email, Phone, Address, Gender_ID, Avatar, Role_ID) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, hashMD5(password));
            ps.setString(3, fullname);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, address);
            ps.setInt(7, gender);
            ps.setString(8, ""); // Default empty avatar
            ps.setInt(9, role);

            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Create user SQL error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Create user general error: " + e.getMessage());
        }
        return false;
    }

    //     public int insertUser(String username, String password, String fullname, String email, String phone, String address,
    //             int genderId, String avatar, int roleId) {
    //         String sql = "INSERT INTO Users (Username, Password, FullName ,Email, Phone, Address, Gender_ID, Avatar, Role_ID) "
    //                 + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    //         try {
    //             PreparedStatement ps = conn.prepareStatement(sql);
    //             ps.setString(1, username);
    //             ps.setString(2, hashMD5(password));
    //             ps.setString(3, fullname);
    //             ps.setString(4, email);
    //             ps.setString(5, phone);
    //             ps.setString(6, address);
    //             ps.setInt(7, genderId);
    //             ps.setString(8, avatar);
    //             ps.setInt(9, roleId);
    //             int row = ps.executeUpdate();
    //             return (row > 0) ? 1 : 0;
    //         } catch (Exception e) {
    //             System.out.println("Insert User Error: " + e.getMessage());
    //             return 0;
    //         }
    //     }
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM Users WHERE User_ID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int num = ps.executeUpdate();
            return num > 0;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public boolean updateUser(int userId, String username, String fullname, String email, String phone, String address,
            int gender, int role) {
        String sql = "UPDATE Users SET Username = ?,  FullName = ?, Email = ?, Phone = ?, Address = ?, Gender_ID = ?, Role_ID = ? WHERE User_ID = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, fullname);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.setInt(6, gender);
            ps.setInt(7, role);
            ps.setInt(8, userId);

            int num = ps.executeUpdate();
            return num > 0; // Nếu cập nhật thành công, trả về true, ngược lại trả về false.
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
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
