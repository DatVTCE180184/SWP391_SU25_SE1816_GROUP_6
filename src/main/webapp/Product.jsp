<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Product product = (Product) request.getAttribute("product");
     session.setAttribute("redirectAfterLogin", "product?action=details&id=" + product.getPro_ID());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= product != null ? product.getPro_Name() : "Product Detail" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="./style/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }
        
        .product-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .product-image {
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease;
        }
        
        .product-image:hover {
            transform: scale(1.02);
        }
        
        .color-option {
            display: inline-block;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            margin: 8px;
            border: 3px solid #e9ecef;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .color-option:hover {
            transform: scale(1.15);
            border-color: #007bff;
            box-shadow: 0 6px 12px rgba(0, 123, 255, 0.3);
        }
        
        .color-option.selected {
            border-color: #007bff;
            box-shadow: 0 0 15px rgba(0, 123, 255, 0.6);
            transform: scale(1.1);
        }
        
        .specs-table {
            background: linear-gradient(145deg, #f8f9fa, #e9ecef);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .specs-table table {
            margin-bottom: 0;
        }
        
        .specs-table td {
            padding: 15px 20px;
            border: none;
            border-bottom: 1px solid rgba(222, 226, 230, 0.5);
        }
        
        .specs-table tr:last-child td {
            border-bottom: none;
        }
        
        .specs-table td:first-child {
            font-weight: 600;
            background: linear-gradient(135deg, #e9ecef, #dee2e6);
            width: 40%;
            color: #495057;
        }
        
        .product-info {
            background: rgba(255, 255, 255, 0.8);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .product-title {
            color: #2c3e50;
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        .product-price {
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 700;
        }
        
        .btn-cart {
            background: linear-gradient(135deg, #ffa726, #ff9800);
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            font-weight: 600;
            box-shadow: 0 6px 15px rgba(255, 152, 0, 0.3);
            transition: all 0.3s ease;
        }
        
        .btn-cart:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 152, 0, 0.4);
            background: linear-gradient(135deg, #ff9800, #f57c00);
        }
        
        .color-section {
            background: rgba(248, 249, 250, 0.8);
            border-radius: 15px;
            padding: 20px;
            margin-top: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        
        .specs-section {
            background: rgba(248, 249, 250, 0.8);
            border-radius: 15px;
            padding: 20px;
            margin-top: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        
        .btn-back {
            background: #e0e0e0;
            border: none;
            border-radius: 15px;
            padding: 12px 32px;
            font-size: 1.2em;
            font-weight: 500;
            color: #222;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            transition: background 0.2s, box-shadow 0.2s, transform 0.2s;
            outline: none;
            margin-bottom: 20px;
        }
        .btn-back:hover {
            background: #d1d1d1;
            box-shadow: 0 4px 16px rgba(0,0,0,0.12);
            transform: translateY(-2px) scale(1.03);
        }
       
        .product-detail-section {
            font-size: 1.08em;
            line-height: 1.7;
            color: #222;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            margin-top: 32px;
        }
        .product-detail-section h3, .product-detail-section h4 {
            color: #2c3e50;
            margin-top: 0;
        }
        .product-detail-section b {
            color: #007bff;
        }
        
        .detail-image-section {
            background: rgba(248, 249, 250, 0.8);
            border-radius: 15px;
            padding: 20px;
            margin-top: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        
        .detail-image {
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease;
            max-width: 100%;
            height: auto;
        }
        
        .detail-image:hover {
            transform: scale(1.02);
        }
        
        .specs-detail-row {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <%@include file="Header.jsp" %>
    <div class="container my-5">
        <!-- Back Button -->
        <button class="btn-back mb-4" onclick="window.history.back()">
            <span style="font-size: 1.2em; margin-right: 6px;">&#8592;</span> <b>Back</b>
        </button>
        <% if (product == null) { %>
            <div class="alert alert-danger text-center">Product not found.</div>
        <% } else { %>
        <div class="product-container p-4">
            <div class="row">
                <!-- Left Column: Image and Specifications -->
                <div class="col-md-5">
                    <img src="<%= product.getPro_Image() %>" class="img-fluid product-image" alt="<%= product.getPro_Name() %>">
                </div>
                
                <!-- Right Column: Product Information and Colors -->
                <div class="col-md-7">
                    <div class="product-info">
                        <h2 class="product-title"><%= product.getPro_Name() %></h2>
                        <p class="text-muted mb-3"><%= product.getPro_Description() %></p>
                        <h3 class="product-price mb-4"><%=  product.getPro_Price() %> $</h3>
                        
                        <form action="cart" method="post" class="mb-4">
                            <input type="hidden" name="action" value="add" />
                            <input type="hidden" name="id" value="<%= product.getPro_ID() %>" />
                            <input type="hidden" name="name" value="<%= product.getPro_Name() %>" />
                            <input type="hidden" name="image" value="<%= product.getPro_Image() %>" />
                            <input type="hidden" name="price" value="<%= product.getPro_Price() %>" />
                            <input type="hidden" name="quantity" value="1" />
                            <button type="submit" class="btn btn-cart btn-lg">🛒 Add to Cart</button>
                        </form>
                        
                        <div class="row mb-3">
                            <div class="col-6">
                                <p class="mb-1"><strong>📦 Quantity in stock:</strong></p>
                                <span class="badge bg-success fs-6"><%= product.getPro_Quantity() %></span>
                            </div>
                            <div class="col-6">
                                <p class="mb-1"><strong>📊 Status:</strong></p>
                                <span class="badge <%= product.isPro_Status() ? "bg-success" : "bg-danger" %> fs-6">
                                    <%= product.isPro_Status() ? "✅ Available" : "❌ Out of stock" %>
                                </span>
                            </div>
                        </div>
                        
                        <!-- Color section at the bottom right -->
                        <% if (product.getPro_Colors() != null && !product.getPro_Colors().trim().isEmpty()) { %>
                        <div class="color-section">
                            <h5 class="mb-3 text-primary">🎨 Available Colors:</h5>
                            <div class="color-selection">
                                <% 
                                String[] colors = product.getPro_Colors().split(",");
                                for (String color : colors) {
                                    String colorName = color.trim();
                                    String colorClass = "";
                                    switch(colorName.toLowerCase()) {
                                        case "đen":
                                        case "black":
                                            colorClass = "background-color: #000;";
                                            break;
                                        case "trắng":
                                        case "white":
                                            colorClass = "background-color: #fff; border: 1px solid #ddd;";
                                            break;
                                        case "xanh":
                                        case "blue":
                                            colorClass = "background-color: #007bff;";
                                            break;
                                        case "tím":
                                        case "purple":
                                            colorClass = "background-color: #6f42c1;";
                                            break;
                                        case "đỏ":
                                        case "red":
                                            colorClass = "background-color: #dc3545;";
                                            break;
                                        case "vàng":
                                        case "yellow":
                                            colorClass = "background-color: #ffc107;";
                                            break;
                                        case "xanh lá":
                                        case "green":
                                            colorClass = "background-color: #28a745;";
                                            break;
                                        default:
                                            colorClass = "background-color: #6c757d;";
                                            break;
                                    }
                                %>
                                <div class="color-option" style="<%= colorClass %>" title="<%= colorName %>"></div>
                                <% } %>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
            
            <!-- Technical specifications and detailed description section below -->
            <div class="specs-detail-row">
                <div class="row">
                    <!-- Technical specifications on the left -->
                    <div class="col-md-6">
                        <% if (product.getPro_Specs() != null && !product.getPro_Specs().trim().isEmpty()) { %>
                        <div class="specs-section">
                            <h3 class="mb-3 text-primary">📋 Technical Specifications</h3>
                            <div class="specs-table">
                                <%= product.getPro_Specs() %>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    
                    <!-- Detailed description on the right -->
                    <div class="col-md-6">
                        <% if (product.getPro_Detail_Image() != null && !product.getPro_Detail_Image().trim().isEmpty()) { %>
                        <div class="detail-image-section">
                            <h3 class="mb-3 text-primary">📖 Detailed Description</h3>
                            <img src="<%= product.getPro_Detail_Image() %>" class="detail-image" alt="Detailed description of <%= product.getPro_Name() %>">
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        
        <% } %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // JavaScript to handle color selection
        document.addEventListener('DOMContentLoaded', function() {
            const colorOptions = document.querySelectorAll('.color-option');
            
            colorOptions.forEach(option => {
                option.addEventListener('click', function() {
                    // Deselect all other colors
                    colorOptions.forEach(opt => opt.classList.remove('selected'));
                    // Select current color
                    this.classList.add('selected');
                });
            });
            
            // Select first color by default
            if (colorOptions.length > 0) {
                colorOptions[0].classList.add('selected');
            }
        });
    </script>
</body>
</html>