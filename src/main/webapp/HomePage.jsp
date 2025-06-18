<%-- 
    Document   : HomePage
    Created on : Jun 16, 2025, 10:04:20 AM
    Author     : ADMIN
--%>

<%@page import="model.Category"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.ProductDao" %>
<%

    List<Product> list_Pro = (List<Product>) request.getAttribute("list_Product");
    List<Category> list_Cat = (List<Category>) request.getAttribute("list_Category");

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap" rel="stylesheet">


        <style>
            .product-card {
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 10px;
                text-align: center;
                margin-bottom: 20px;
                height: 100%;
            }
            .product-card img {
                max-width: 100%;
                height: auto;
            }
            .price {
                color: red;
                font-weight: bold;
            }
        </style>

    </head>
    <body>



        <div class="container-fluid mt-3" >

            <div>
                <header>
                    hello world!
                </header>

            </div>



            <div class="row">
                <div class="col-sm-4 p-3 ">
 <%                        if (list_Cat != null) {
                    %>
                    <div class="row">

                        <%
                            for (Category cat : list_Cat) {
                        %>

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="product-card">
                                <img src="<%= cat.getCat_img() %>" alt="<%= cat.getCat_Name() %>">
                                <h6><%= cat.getCat_Name() %></h6>
                                
                                <p> <%= cat.getCat_Description() %></p>
                                
                            </div>
                        </div>
                        <%
                            }
                        %>

                    </div>
                    <%
                        } else {
                            out.println("No Data!");
                        }
                    %>

                </div>

                <div class="col-md-9">
                    <%                        if (list_Pro != null) {
                    %>
                    <div class="row">

                        <%
                            for (Product pro : list_Pro) {
                        %>

                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="product-card">
                                <img src="<%= pro.getPro_Image() %>" alt="<%= pro.getPro_Name() %>">
                                <h6><%= pro.getPro_Name() %></h6>
                                <p class="price"><%= pro.getPro_Price() %></p>
                                <p> <%= pro.getPro_Description() %></p>
                                <button  harclass="btn btn-primary btn-sm">Thêm vào giỏ</button>
                            </div>
                        </div>
                        <%
                            }
                        %>

                    </div>
                    <%
                        } else {
                            out.println("No Data!");
                        }
                    %>

                </div>
            </div>



        </div>

    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
