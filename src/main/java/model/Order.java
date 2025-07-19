/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Order {
    private int Order_ID;
    private int User_ID;
    
    private String Order_Date;
    private String Shipping_Address;
    private String Order_FullName;
    private String Order_Phone;
    private String Note;
    
    private double Total_Amout;
    private String Payment_Method;
    private String Order_Status;
    private java.util.List<String> productNames;// cai nay cho puschase history cua profile

    public Order() {
        this.Order_ID = -1;
        this.User_ID = -1;
        this.Order_Date = "";
        this.Shipping_Address = "";
        this.Order_FullName = "";
        this.Order_Phone = "";
        this.Note = "";
        this.Total_Amout = 0.0;
        this.Payment_Method = "";
        this.Order_Status = "";
    }

    public Order(int Order_ID, int User_ID, String Order_Date, String Shipping_Address, String Order_FullName, String Order_Phone, String Note, double Total_Amout, String Payment_Method, String Order_Status) {
        this.Order_ID = Order_ID;
        this.User_ID = User_ID;
        this.Order_Date = Order_Date;
        this.Shipping_Address = Shipping_Address;
        this.Order_FullName = Order_FullName;
        this.Order_Phone = Order_Phone;
        this.Note = Note;
        this.Total_Amout = Total_Amout;
        this.Payment_Method = Payment_Method;
        this.Order_Status = Order_Status;
    }

    public int getOrder_ID() {
        return Order_ID;
    }

    public void setOrder_ID(int Order_ID) {
        this.Order_ID = Order_ID;
    }

    public int getUser_ID() {
        return User_ID;
    }

    public void setUser_ID(int User_ID) {
        this.User_ID = User_ID;
    }

    public String getOrder_Date() {
        return Order_Date;
    }

    public void setOrder_Date(String Order_Date) {
        this.Order_Date = Order_Date;
    }

    public String getShipping_Address() {
        return Shipping_Address;
    }

    public void setShipping_Address(String Shipping_Address) {
        this.Shipping_Address = Shipping_Address;
    }

    public String getOrder_Phone() {
        return Order_Phone;
    }

    public void setOrder_Phone(String Order_Phone) {
        this.Order_Phone = Order_Phone;
    }

    public String getNote() {
        return Note;
    }

    public void setNote(String Note) {
        this.Note = Note;
    }

    public double getTotal_Amout() {
        return Total_Amout;
    }

    public void setTotal_Amout(double Total_Amout) {
        this.Total_Amout = Total_Amout;
    }

    public String getPayment_Method() {
        return Payment_Method;
    }

    public void setPayment_Method(String Payment_Method) {
        this.Payment_Method = Payment_Method;
    }

    public String getOrder_Status() {
        return Order_Status;
    }

    public void setOrder_Status(String Order_Status) {
        this.Order_Status = Order_Status;
    }

    public String getOrder_FullName() {
        return Order_FullName;
    }

    public void setOrder_FullName(String Order_FullName) {
        this.Order_FullName = Order_FullName;
    }
    // puschase history cua profile
    public java.util.List<String> getProductNames() {
        return productNames;
    }
    public void setProductNames(java.util.List<String> productNames) {
        this.productNames = productNames;
    }

    @Override
    public String toString() {
        return "Order{" + "Order_ID=" + Order_ID + ", User_ID=" + User_ID + ", Order_Date=" + Order_Date + ", Shipping_Address=" + Shipping_Address + ", Order_FullName=" + Order_FullName + ", Order_Phone=" + Order_Phone + ", Note=" + Note + ", Total_Amout=" + Total_Amout + ", Payment_Method=" + Payment_Method + ", Order_Status=" + Order_Status + '}';
    }

    
    
}
