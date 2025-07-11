<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Product> list_Search = (List<Product>) request.getAttribute("products");
    String keyword = (String) request.getAttribute("keyword");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results for "<%= keyword %>"</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="./style/style.css" />
</head>
<body>
    <%@include file="Header.jsp" %>
    <div class="container my-5">
        <h2 class="mb-4 text-center">
                            <i class="fa fa-search text-primary"></i> Results for keyword: <span class="text-success">"<%= keyword %>"</span>
        </h2>
        <!-- Search Filter + Sort -->
        <form class="row g-3 align-items-end mb-4" method="post" action="search">
            <input type="hidden" name="keyword" value="<%= keyword %>" />
            <div class="col-md-3">
                <label class="form-label">Price Range</label>
                <select class="form-select" name="price">
                    <option value="">All</option>
                    <option value="0-5000000">Under 5 million</option>
                    <option value="5000000-10000000">5 - 10 million</option>
                    <option value="10000000-20000000">10 - 20 million</option>
                    <option value="20000000-999999999">Over 20 million</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label">Rating</label>
                <select class="form-select" name="rating">
                    <option value="">All</option>
                    <option value="5">5 ★</option>
                    <option value="4">4 ★ and above</option>
                    <option value="3">3 ★ and above</option>
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label">Sort by</label>
                <select class="form-select" name="sort">
                    <option value="">Default</option>
                    <option value="price_asc">Price: Low to High</option>
                    <option value="price_desc">Price: High to Low</option>
                    <option value="name_asc">Name: A-Z</option>
                    <option value="name_desc">Name: Z-A</option>
                    <option value="id_desc">Newest</option>
                    <option value="id_asc">Oldest</option>
                </select>
            </div>
            <div class="col-md-1">
                <button type="submit" class="btn btn-primary w-100"><i class="fa fa-filter"></i> Filter</button>
            </div>
        </form>
        <% if (list_Search == null || list_Search.isEmpty()) { %>
            <div class="alert alert-warning text-center py-5">
                <i class="fa fa-box-open fa-2x mb-3"></i><br/>
                No products found!
            </div>
        <% } else { %>
        <div class="mb-3 text-end text-muted">
            <i class="fa fa-box"></i> Found <b><%= list_Search.size() %></b> products
        </div>
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
            <% for (Product pro : list_Search) { %>
            <div class="col d-flex align-items-stretch">
                <div class="card h-100 shadow product-card-hover">
                    <a href="product?action=details&id=<%= pro.getPro_ID()%>">
                        <img src="<%= pro.getPro_Image()%>" class="card-img-top" alt="<%= pro.getPro_Name()%>" style="object-fit:cover; height:200px;" />
                    </a>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-truncate" title="<%= pro.getPro_Name()%>"><%= pro.getPro_Name()%></h5>
                        <p class="card-text text-truncate" title="<%= pro.getPro_Description()%>">
                            <%= pro.getPro_Description()%>
                        </p>
                        <strong class="mt-auto" style="color: #e74c3c; font-size: 1.1rem;">
                            <%= String.format("%,.0f", pro.getPro_Price()) %> ₫
                        </strong>
                    </div>
                    <div class="card-footer bg-white border-0 mt-auto">
                        <form action="cart" method="post">
                            <input type="hidden" name="action" value="add" />
                            <input type="hidden" name="id" value="<%= pro.getPro_ID()%>" />
                            <input type="hidden" name="name" value="<%= pro.getPro_Name()%>" />
                            <input type="hidden" name="image" value="<%= pro.getPro_Image()%>" />
                            <input type="hidden" name="price" value="<%= pro.getPro_Price()%>" />
                            <input type="hidden" name="quantity" value="1" />
                            <button type="submit" class="btn btn-warning w-100">🛒 Add to Cart</button>
                        </form>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>
    <style>
    .product-card-hover {
        transition: transform 0.15s, box-shadow 0.15s;
    }
    .product-card-hover:hover {
        transform: translateY(-6px) scale(1.03);
        box-shadow: 0 8px 24px rgba(0,0,0,0.12);
        z-index: 2;
    }
    .card-title.text-truncate, .card-text.text-truncate {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>