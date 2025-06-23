package dao;

import model.Product;

public class AdminDAO {
    public static String formatProductInfo(Product product) {
        return String.format("%s - %s (%.0f VND) - Quantity: %d", 
            product.getPro_Name(), product.getPro_Description(), 
            product.getPro_Price(), product.getPro_Quantity());
    }
}