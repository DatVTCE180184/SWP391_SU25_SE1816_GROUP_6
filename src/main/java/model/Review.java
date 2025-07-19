package model;

import java.sql.Timestamp;

public class Review {
    private int review_ID;
    private int user_ID;
    private int product_ID;
    private int order_ID;
    private int rating;
    private String comment;
    private Timestamp review_Date;

 

    public Review() {
        this.review_ID = -1;
        this.user_ID = -1;
        this.product_ID = -1;
        this.order_ID = -1;
        this.rating = 0;
        this.comment = "";
        this.review_Date = null;
       
    }

   

    public Review(int review_ID, int user_ID, int product_ID, int order_ID, int rating, String comment, Timestamp review_Date, String username, String productName, String orderStatus) {
        this.review_ID = review_ID;
        this.user_ID = user_ID;
        this.product_ID = product_ID;
        this.order_ID = order_ID;
        this.rating = rating;
        this.comment = comment;
        this.review_Date = review_Date;
    }

    public int getReview_ID() {
        return review_ID;
    }

    public void setReview_ID(int review_ID) {
        this.review_ID = review_ID;
    }

    public int getUser_ID() {
        return user_ID;
    }

    public void setUser_ID(int user_ID) {
        this.user_ID = user_ID;
    }

    public int getProduct_ID() {
        return product_ID;
    }

    public void setProduct_ID(int product_ID) {
        this.product_ID = product_ID;
    }

    public int getOrder_ID() {
        return order_ID;
    }

    public void setOrder_ID(int order_ID) {
        this.order_ID = order_ID;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getReview_Date() {
        return review_Date;
    }

    public void setReview_Date(Timestamp review_Date) {
        this.review_Date = review_Date;
    }

    public Review(int review_ID, int user_ID, int product_ID, int order_ID, int rating, String comment, Timestamp review_Date) {
        this.review_ID = review_ID;
        this.user_ID = user_ID;
        this.product_ID = product_ID;
        this.order_ID = order_ID;
        this.rating = rating;
        this.comment = comment;
        this.review_Date = review_Date;
    }

   


}
