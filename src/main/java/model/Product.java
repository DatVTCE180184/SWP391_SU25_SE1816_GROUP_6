/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Product {
    private int Pro_ID;
    private int Cat_ID;
    
    private String Pro_Name;
    private String Pro_Description;
    private String Pro_Image;
    
    private double Pro_Price;
    private int Pro_Quantity;
    private boolean Pro_Status;
      
    // Thêm các trường mới cho màu sắc và thông số kỹ thuật
    private String Pro_Colors;
    private String Pro_Specs;
    // chi tiết sản phẩm 
    private String Pro_Detail_Image;

    public Product() {
        this.Pro_ID = -1;
        this.Cat_ID = -1;
        this.Pro_Name = "";
        this.Pro_Description = "";
        this.Pro_Image = "";
        this.Pro_Price = 0.0;
        this.Pro_Quantity = 0;
        this.Pro_Status = false;
        this.Pro_Colors = "";
        this.Pro_Specs = "";
        // chi tiết sản phẩm 
        this.Pro_Detail_Image = "";
    }

    public Product(int Pro_ID, int Cat_ID, String Pro_Name, String Pro_Description, String Pro_Image, double Pro_Price, int Pro_Quantity, int Pro_Status) {
        this.Pro_ID = Pro_ID;
        this.Cat_ID = Cat_ID;
        this.Pro_Name = Pro_Name;
        this.Pro_Description = Pro_Description;
        this.Pro_Image = Pro_Image;
        this.Pro_Price = Pro_Price;
        this.Pro_Quantity = Pro_Quantity;
        this.Pro_Status = (Pro_Status == 1);
        this.Pro_Colors = "";
        this.Pro_Specs = "";
        // chi tiết sản phẩm 
        this.Pro_Detail_Image = "";
    }

    // Constructor mới với đầy đủ thông tin
    public Product(int Pro_ID, int Cat_ID, String Pro_Name, String Pro_Description, String Pro_Image, double Pro_Price, int Pro_Quantity, int Pro_Status, String Pro_Colors, String Pro_Specs, String Pro_Detail_Image) {
        this.Pro_ID = Pro_ID;
        this.Cat_ID = Cat_ID;
        this.Pro_Name = Pro_Name;
        this.Pro_Description = Pro_Description;
        this.Pro_Image = Pro_Image;
        this.Pro_Price = Pro_Price;
        this.Pro_Quantity = Pro_Quantity;
        this.Pro_Status = (Pro_Status == 1);
        this.Pro_Colors = Pro_Colors != null ? Pro_Colors : "";
        this.Pro_Specs = Pro_Specs != null ? Pro_Specs : "";
        // chi tiết sản phẩm
        this.Pro_Detail_Image = Pro_Detail_Image != null ? Pro_Detail_Image : "";
    }

    public int getPro_ID() {
        return Pro_ID;
    }

    public void setPro_ID(int Pro_ID) {
        this.Pro_ID = Pro_ID;
    }

    public int getCat_ID() {
        return Cat_ID;
    }

    public void setCat_ID(int Cat_ID) {
        this.Cat_ID = Cat_ID;
    }

    public String getPro_Name() {
        return Pro_Name;
    }

    public void setPro_Name(String Pro_Name) {
        this.Pro_Name = Pro_Name;
    }

    public String getPro_Description() {
        return Pro_Description;
    }

    public void setPro_Description(String Pro_Description) {
        this.Pro_Description = Pro_Description;
    }

    public String getPro_Image() {
        return Pro_Image;
    }

    public void setPro_Image(String Pro_Image) {
        this.Pro_Image = Pro_Image;
    }

    public double getPro_Price() {
        return Pro_Price;
    }

    public void setPro_Price(double Pro_Price) {
        this.Pro_Price = Pro_Price;
    }

    public int getPro_Quantity() {
        return Pro_Quantity;
    }

    public void setPro_Quantity(int Pro_Quantity) {
        this.Pro_Quantity = Pro_Quantity;
    }

    public boolean isPro_Status() {
        return Pro_Status;
    }

    public void setPro_Status(boolean Pro_Status) {
        this.Pro_Status = Pro_Status;
    }

    // Thêm getter và setter cho màu sắc
    public String getPro_Colors() {
        return Pro_Colors;
    }

    public void setPro_Colors(String Pro_Colors) {
        this.Pro_Colors = Pro_Colors;
    }

    // Thêm getter và setter cho thông số kỹ thuật
    public String getPro_Specs() {
        return Pro_Specs;
    }

    public void setPro_Specs(String Pro_Specs) {
        this.Pro_Specs = Pro_Specs;
    }
// chi tiết sản phẩm 
    public String getPro_Detail_Image() {
        return Pro_Detail_Image;
    }

    public void setPro_Detail_Image(String Pro_Detail_Image) {
        this.Pro_Detail_Image = Pro_Detail_Image;
    }
// chi tiết sản phẩm 
    @Override
    public String toString() {
        return "Product{" + "Pro_ID=" + Pro_ID + ", Cat_ID=" + Cat_ID + ", Pro_Name=" + Pro_Name + ", Pro_Description=" + Pro_Description + ", Pro_Image=" + Pro_Image + ", Pro_Price=" + Pro_Price + ", Pro_Quantity=" + Pro_Quantity + ", Pro_Status=" + Pro_Status + ", Pro_Colors=" + Pro_Colors + ", Pro_Specs=" + Pro_Specs + ", Pro_Detail_Image=" + Pro_Detail_Image + '}';
    }
    
    
    
    
}
