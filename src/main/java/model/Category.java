/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Category {

    private int Cat_ID;
    private String Cat_Name;
    private String Cat_Description;

    private int Cat_Parent_ID;
    private String Cat_img;
    private Boolean Cat_Status;

    public Category() {
        this.Cat_ID = -1;
        this.Cat_Name = "";
        this.Cat_Description = "";
        this.Cat_Parent_ID = -1;
        this.Cat_img = "";
        this.Cat_Status = false;
    }

    public Category(int Cat_ID, String Cat_Name, String Cat_Description, int Cat_Parent_ID, String Cat_img, boolean Cat_Status) {
        this.Cat_ID = Cat_ID;
        this.Cat_Name = Cat_Name;
        this.Cat_Description = Cat_Description;
        this.Cat_Parent_ID = Cat_Parent_ID;
        this.Cat_img = Cat_img;
        this.Cat_Status = Cat_Status;
    }

    public int getCat_ID() {
        return Cat_ID;
    }

    public void setCat_ID(int Cat_ID) {
        this.Cat_ID = Cat_ID;
    }

    public String getCat_Name() {
        return Cat_Name;
    }

    public void setCat_Name(String Cat_Name) {
        this.Cat_Name = Cat_Name;
    }

    public String getCat_Description() {
        return Cat_Description;
    }

    public void setCat_Description(String Cat_Description) {
        this.Cat_Description = Cat_Description;
    }

    public int getCat_Parent_ID() {
        return Cat_Parent_ID;
    }

    public void setCat_Parent_ID(int Cat_Parent_ID) {
        this.Cat_Parent_ID = Cat_Parent_ID;
    }

    public String getCat_img() {
        return Cat_img;
    }

    public void setCat_img(String Cat_img) {
        this.Cat_img = Cat_img;
    }

    public boolean getCat_Status() {
        return Cat_Status;
    }

    public void setCat_Status(boolean Cat_Status) {
        this.Cat_Status = Cat_Status;
    }

    @Override
    public String toString() {
        return "Category{" + "Cat_ID=" + Cat_ID + ", Cat_Name=" + Cat_Name + ", Cat_Description=" + Cat_Description + ", Cat_Parent_ID=" + Cat_Parent_ID + ", Cat_img=" + Cat_img + ", Cat_Status=" + Cat_Status + '}';
    }

}
