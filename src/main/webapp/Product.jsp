<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Product product = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= product != null ? product.getPro_Name() : "Product Detail" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="./style/style.css" />
</head>
<body>
    <%@include file="Header.jsp" %>
    <div class="container my-5">
        <% if (product == null) { %>
            <div class="alert alert-danger text-center">Product not found.</div>
        <% } else { %>
        <div class="row">
            <div class="col-md-5">
                <img src="<%= product.getPro_Image() %>" class="img-fluid rounded shadow" alt="<%= product.getPro_Name() %>">
            </div>
            <div class="col-md-7">
                <h2><%= product.getPro_Name() %></h2>
                <p class="text-muted"><%= product.getPro_Description() %></p>
                <h4 class="text-danger mb-4"><%= String.format("%,.0f", product.getPro_Price()) %> ₫</h4>
                <form action="cart" method="post" class="mb-3">
                    <input type="hidden" name="action" value="add" />
                    <input type="hidden" name="id" value="<%= product.getPro_ID() %>" />
                    <input type="hidden" name="name" value="<%= product.getPro_Name() %>" />
                    <input type="hidden" name="image" value="<%= product.getPro_Image() %>" />
                    <input type="hidden" name="price" value="<%= product.getPro_Price() %>" />
                    <input type="hidden" name="quantity" value="1" />
                    <button type="submit" class="btn btn-warning btn-lg">🛒 Add to Cart</button>
                </form>
                <p><strong>Quantity in stock:</strong> <%= product.getPro_Quantity() %></p>
                <p><strong>Status:</strong> <%= product.isPro_Status() ? "Available" : "Out of stock" %></p>
            </div>
        </div>
        <% } %>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>