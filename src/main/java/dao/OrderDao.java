/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.List;
import model.CartItem;
import model.User;
import utils.DBContext;

/**
 *
 * @author ADMIN
 */
public class OrderDao extends DBContext {

    public OrderDao() {
        super();
    }
    
    public void createOrder(List<CartItem> cart, String userID, String fullName, 
            String phone, String note, String Payment_Method, String address){
        
        
        
    }
    
    

    public static void main(String[] args) {
        OrderDao orDao = new OrderDao();
        
    }
}
