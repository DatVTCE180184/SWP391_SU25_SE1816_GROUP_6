<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    
    List<Product> list_Product_by_Category = (List<Product>) request.getAttribute("list_Product_by_Category");
    String categoryName = (String) request.getAttribute("keyword");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= categoryName != null ? categoryName : "Smartphones" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="./style/style.css" />
</head>
<body>
    <%@include file="Header.jsp" %>
        <div class="container my-5">
        <h2 class="mb-4 text-center">
            <i class="fa fa-search text-primary"></i> Kết quả cho từ khóa: <span class="text-success">"<%=  categoryName %>"</span>
        </h2>
        <!-- Bộ lọc tìm kiếm + Sắp xếp -->
        <form class="row g-3 align-items-end mb-4" method="post" action="search">
            <input type="hidden" name="keyword" value="<%= categoryName  %>" />
            
            <div class="col-md-3">
                <label class="form-label">Khoảng giá</label>
                <select class="form-select" name="price">
                    <option value="">Tất cả</option>
                    <option value="0-5000000">Dưới 5 triệu</option>
                    <option value="5000000-10000000">5 - 10 triệu</option>
                    <option value="10000000-20000000">10 - 20 triệu</option>
                    <option value="20000000-999999999">Trên 20 triệu</option>
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label">Đánh giá</label>
                <select class="form-select" name="rating">
                    <option value="">Tất cả</option>
                    <option value="5">5 ★</option>
                    <option value="4">4 ★ trở lên</option>
                    <option value="3">3 ★ trở lên</option>
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label">Sắp xếp theo</label>
                <select class="form-select" name="sort">
                    <option value="">Mặc định</option>
                    <option value="price_asc">Giá tăng dần</option>
                    <option value="price_desc">Giá giảm dần</option>
                    <option value="name_asc">Tên A-Z</option>
                    <option value="name_desc">Tên Z-A</option>
                    <option value="id_desc">Mới nhất</option>
                    <option value="id_asc">Cũ nhất</option>
                </select>
            </div>
            <div class="col-md-1">
                <button type="submit" class="btn btn-primary w-100"><i class="fa fa-filter"></i> Lọc</button>
            </div>
        </form>
    <div class="container my-5">
        <h2 class="mb-4 text-center"><%= categoryName != null ? categoryName : "Smartphones" %></h2>
        <% if (list_Product_by_Category == null || list_Product_by_Category.isEmpty()) { %>
            <div class="alert alert-warning text-center">No smartphones available.</div>
        <% } else { %>
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
            <% for (Product pro : list_Product_by_Category) { %>
            <div class="col d-flex align-items-stretch">
                <div class="card h-100 shadow">
                    <a href="product?action=details&id=<%= pro.getPro_ID()%>">
                        <img src="<%= pro.getPro_Image()%>" class="card-img-top" alt="<%= pro.getPro_Name()%>" />
                    </a>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title"><%= pro.getPro_Name()%></h5>
                        <p class="card-text"><%= pro.getPro_Description()%></p>
                        <strong style="color: red"><%= String.format("%,.0f", pro.getPro_Price()) %> ₫</strong>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>