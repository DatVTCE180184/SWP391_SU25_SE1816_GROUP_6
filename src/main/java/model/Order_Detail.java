/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


import java.util.HashMap;
import model.Product;

/**
 *
 * @author ADMIN
 */
public class Order_Detail {
    private int Order_Detail_ID;
    private int Order_ID;
    
    private int Quantity;
    private HashMap<Product,Integer> List_Product;

    public Order_Detail() {
        this.Order_Detail_ID = -1;
        this.Order_ID = -1;
        
        this.Quantity = Quantity;
        this.List_Product = List_Product;
    }

    public Order_Detail(int Order_Detail_ID, int Order_ID, int Quantity, HashMap<Product, Integer> List_Product) {
        this.Order_Detail_ID = Order_Detail_ID;
        this.Order_ID = Order_ID;
        
        this.Quantity = Quantity;
        this.List_Product = List_Product;
    }

    public int getOrder_Detail_ID() {
        return Order_Detail_ID;
    }

    public void setOrder_Detail_ID(int Order_Detail_ID) {
        this.Order_Detail_ID = Order_Detail_ID;
    }

    public int getOrder_ID() {
        return Order_ID;
    }

    public void setOrder_ID(int Order_ID) {
        this.Order_ID = Order_ID;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public HashMap<Product, Integer> getList_Product() {
        return List_Product;
    }

    public void setList_Product(HashMap<Product, Integer> List_Product) {
        this.List_Product = List_Product;
    }

    @Override
    public String toString() {
        return "Order_Detail{" + "Order_Detail_ID=" + Order_Detail_ID + ", Order_ID=" + Order_ID + ", Quantity=" + Quantity + ", List_Product=" + List_Product + '}';
    }
    
    
    
}
