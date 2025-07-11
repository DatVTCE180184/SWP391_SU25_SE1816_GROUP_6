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
    private String fullname;
    private String email;
    private String phone;
    private String address;
    private int gender;
    private String avatar;
    private int role_ID;

    public User() {
        this.ID = -1;
        this.username = "";
        this.password = "";
        this.fullname = "";
        this.email = "";
        this.phone = "";
        this.address = "";
        this.gender = 3;
        this.avatar = "";
        this.role_ID = 0;
    }

    public User(int ID, String username, String password, String fullname ,String email, String phone, String address, int gender, String avatar, int role_ID) {
        this.ID = ID;
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.gender = gender;
        this.avatar = avatar;
        this.role_ID = role_ID;
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

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
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

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public int getRole_ID() {
        return role_ID;
    }

    public void setRole_ID(int role_ID) {
        this.role_ID = role_ID;
    }

    @Override
    public String toString() {
        return "User{" + "ID=" + ID + ", username=" + username + ", password=" + password + ", fullname=" + fullname + ", email=" + email + ", phone=" + phone + ", address=" + address + ", gender=" + gender + ", avatar=" + avatar + ", role_ID=" + role_ID + '}';
    }

    

}
