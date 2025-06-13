/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class User {

    private int ID;

    private String username;
    private String password;
    private String email;
    private String phone;
    private String address;
    private String gender;
    private String avatar;
    private String role;

    public User() {
        this.ID = -1;
        this.username = "";
        this.password = "";
        this.email = "";
        this.phone = "";
        this.address = "";
        this.gender = "";
        this.avatar = "";
        this.role = "";
    }

    public User(int ID, String username, String password, String email, String phone, String address, String gender, String avatar, String role) {
        this.ID = ID;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.gender = gender;
        this.avatar = avatar;
        this.role = role;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getRole_ID() {
        return role;
    }

    public void setRole_ID(String role_ID) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "User{" + "ID=" + ID + ", username=" + username + ", password=" + password + ", email=" + email + ", phone=" + phone + ", address=" + address + ", gender=" + gender + ", avatar=" + avatar + ", role_ID=" + role + '}';
    }
    
    

}
