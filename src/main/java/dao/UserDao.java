/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

    public List<User> getAllUser() {
        List<User> listUser = new ArrayList<>();
        String sql = "SELECT	U.User_ID, U.Username, U.Password,\n"
                + "		U.Email, U.Phone, U.Address,\n"
                + "		G.Gender_Name, U.Avatar,  R.Role_Name,\n"
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
                        rs.getString("Gender_Name"), rs.getString("Avatar"),  rs.getString("Role_Name"));
                listUser.add(user);
            }

        } catch (Exception e) {
        }
        return listUser;
    }

    public static void main(String[] args) {
        UserDao dao = new UserDao();
        for (User u : dao.getAllUser() ){
            System.out.println(u.toString());
        }
    }
}
