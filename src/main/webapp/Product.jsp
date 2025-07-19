<%@page import="model.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Product product = (Product) request.getAttribute("product");
     session.setAttribute("redirectAfterLogin", "product?action=details&id=" + product.getPro_ID());
     
    // Lấy danh sách feedback cho sản phẩm này
    java.util.List<model.Review> productReviews = null;
    int currentUserId = -1;
    if (session.getAttribute("user") != null) {
        currentUserId = ((model.User)session.getAttribute("user")).getID();
    }
    dao.ReviewDao reviewDao = new dao.ReviewDao();
    productReviews = reviewDao.getReviewsByProductId(product.getPro_ID());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= product != null ? product.getPro_Name() : "Product Detail"%></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="./style/style.css" />
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
                min-height: 420px;
                height: 100%;
            }
            .row.align-items-stretch {
                height: 100%;
            }
            .col-md-6.d-flex {
                height: 100%;
                display: flex;
                flex-direction: column;
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
            .specs-table table {
              width: 100% !important;
              table-layout: auto;
              word-break: break-word;
            }
            .col-md-6, .col-md-5, .col-md-7 {
              min-width: 0;
            }
            .product-image {
              width: 100% !important;
              height: auto !important;
              object-fit: contain !important;
              display: block;
              background: #fff;
            }
            .product-container.d-flex {
                display: flex;
                align-items: stretch;
                min-height: 420px;
                gap: 32px;
            }
            .product-card {
                flex: 1 1 0;
                display: flex;
                flex-direction: column;
                background: #fff;
                border-radius: 18px;
                box-shadow: 0 4px 24px rgba(0,0,0,0.08);
                padding: 32px;
            }
            .product-card img {
                margin-top: auto;
            }
            .product-container .col-md-6 {
                display: flex;
                flex-direction: column;
                justify-content: center;
                height: 100%;
            }
        </style>
    </head>
    <body>
        <%@include file="Header.jsp" %>
        <div class="container my-5 h-100">
            <!-- Nút Back -->
            <button class="btn-back mb-4" onclick="window.history.back()">
                <span style="font-size: 1.2em; margin-right: 6px;">&#8592;</span> <b>Back</b>
            </button>
            <% if (product == null) { %>
            <div class="alert alert-danger text-center">Product not found.</div>
            <% } else {%>
            <div class="product-container p-4 d-flex" style="min-height: 420px;">
                <!-- Cột trái: Hình ảnh sản phẩm -->
                <div class="product-card col-md-6 d-flex flex-column justify-content-end align-items-center">
                        <img src="<%= product.getPro_Image()%>" class="img-fluid product-image" alt="<%= product.getPro_Name()%>" style="max-width: 80%; max-height: 400px; object-fit: contain;">
                </div>
                <!-- Cột phải: Thông tin sản phẩm và màu sắc -->
                <div class="product-card col-md-6 d-flex flex-column justify-content-center">
                        <div class="product-info w-100">
                            <h2 class="product-title"><%= product.getPro_Name()%></h2>
                            <p class="text-muted mb-3"><%= product.getPro_Description()%></p>
                            <h3 class="product-price mb-4"><%= String.format("%,.0f", product.getPro_Price())%> ₫</h3>

                            <form action="cart" method="post" class="mb-4">
                                <input type="hidden" name="action" value="add" />
                                <input type="hidden" name="id" value="<%= product.getPro_ID()%>" />
                                <input type="hidden" name="name" value="<%= product.getPro_Name()%>" />
                                <input type="hidden" name="image" value="<%= product.getPro_Image()%>" />
                                <input type="hidden" name="price" value="<%= product.getPro_Price()%>" />
                                <input type="hidden" name="quantity" value="1" />
                                <button type="submit" class="btn btn-cart btn-lg">🛒 Add to Cart</button>
                            </form>

                            <div class="row mb-3">
                                <div class="col-6">
                                    <p class="mb-1"><strong>📦 Quantity in stock:</strong></p>
                                    <span class="badge bg-success fs-6"><%= product.getPro_Quantity()%></span>
                                </div>
                                <div class="col-6">
                                    <p class="mb-1"><strong>📊 Status:</strong></p>
                                    <span class="badge <%= product.isPro_Status() ? "bg-success" : "bg-danger"%> fs-6">
                                        <%= product.isPro_Status() ? "✅ Available" : "❌ Out of stock"%>
                                    </span>
                                </div>
                            </div>

                            <!-- Phần màu sắc nằm cuối bên phải -->
                            <% if (product.getPro_Colors() != null && !product.getPro_Colors().trim().isEmpty()) { %>
                            <div class="color-section">
                                <h5 class="mb-3 text-primary">🎨 Màu sắc có sẵn:</h5>
                                <div class="color-selection">
                                    <%
                                        String[] colors = product.getPro_Colors().split(",");
                                        for (String color : colors) {
                                            String colorName = color.trim();
                                            String colorClass = "";
                                            switch (colorName.toLowerCase()) {
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
                                    <div class="color-option" style="<%= colorClass%>" title="<%= colorName%>"></div>
                                    <% } %>
                                </div>
                            </div>
                            <% } %>
                        </div> <!-- Đóng product-info -->
                </div> <!-- Đóng col-md-6 phải -->
            </div> <!-- Đóng product-container -->

                <!-- Accordion và mô tả chi tiết nằm song song -->
                <div class="row mt-4">
                    <!-- Accordion thông số kỹ thuật có thêm mới ngày 11/7-->
                    <div class="col-md-6">
                        <c:if test="${not empty groupList}">
                            <div class="specs-section">
                                <h4 class="mb-3">📋Technical Specifications</h4>
                                <div class="accordion" id="specAccordion">
                                    <c:forEach var="group" items="${groupList}">
                                        <div class="accordion-item">
                                            <h2 class="accordion-header" id="heading${group.groupId}">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                        data-bs-target="#collapse${group.groupId}" aria-expanded="false"
                                                        aria-controls="collapse${group.groupId}">
                                                    ${group.groupName}
                                                </button>
                                            </h2>
                                            <div id="collapse${group.groupId}" class="accordion-collapse collapse"
                                                 aria-labelledby="heading${group.groupId}" data-bs-parent="#specAccordion">
                                                <div class="accordion-body">
                                                    <table class="table">
                                                        <c:forEach var="spec" items="${group.specList}">
                                                            <c:if test="${not empty spec.specValue}">
                                                                <tr>
                                                                    <td><b>${spec.specName}</b></td>
                                                                    <td>${spec.specValue}</td>
                                                                </tr>
                                                            </c:if>
                                                        </c:forEach>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    <!-- Mô tả chi tiết -->
                    <div class="col-md-6">
                        <% if (product.getPro_Detail_Image() != null && !product.getPro_Detail_Image().trim().isEmpty()) {%>
                        <div class="detail-image-section">
                            <h3 class="mb-3 text-primary">📖 Mô tả chi tiết</h3>
                            <img src="<%= product.getPro_Detail_Image()%>" class="detail-image" alt="Mô tả chi tiết <%= product.getPro_Name()%>">
                        </div>
                        <% } %>
                    </div>
                </div>

            <% }%>
                    <!-- FORM FEEDBACK USER -->
<% if (session.getAttribute("user") != null && ((model.User)session.getAttribute("user")).getRole_ID() == 3) { %>
<div class="card mt-4 shadow-sm">
    <div class="card-header bg-warning text-dark fw-bold">
        Đánh giá sản phẩm
    </div>
    <form method="post" action="product">
        <input type="hidden" name="action" value="addFeedback"/>
        <input type="hidden" name="productId" value="<%= product.getPro_ID() %>"/>
        <input type="hidden" name="userId" value="<%= ((model.User)session.getAttribute("user")).getID() %>"/>
        <div class="card-body">
            <div class="mb-3">
                <label class="form-label">Đánh giá (1-5 sao)</label>
                <select class="form-select" name="rating" required>
                    <option value="5">5 ★★★★★</option>
                    <option value="4">4 ★★★★</option>
                    <option value="3">3 ★★★</option>
                    <option value="2">2 ★★</option>
                    <option value="1">1 ★</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Bình luận</label>
                <textarea class="form-control" name="comment" rows="3" maxlength="255" required placeholder="Nhập nhận xét của bạn..."></textarea>
            </div>
            <button type="submit" class="btn btn-warning">Gửi đánh giá</button>
        </div>
    </form>
</div>
<% } %>

<!-- HIỂN THỊ FEEDBACK CỦA USER ĐANG ĐĂNG NHẬP -->
<div class="card mt-4">
    <div class="card-header bg-light fw-bold">Đánh giá của bạn</div>
    <div class="card-body" id="feedbackList">
        <%
            model.Review userReview = null;
            if (productReviews != null) {
                for (model.Review rv : productReviews) {
                    if (rv.getUser_ID() == currentUserId) {
                        userReview = rv;
                        break;
                    }
                }
            }
            if (userReview != null) {
        %>
            <div class="border-bottom pb-2 mb-2">
                <span class="badge bg-warning text-dark me-2"> <%= userReview.getRating() %> ★</span>
                <span><%= userReview.getComment() %></span>
                <span class="text-muted float-end" style="font-size:0.9em"><%= userReview.getReview_Date() != null ? userReview.getReview_Date().toString() : "" %></span>
            </div>
        <%
            } else {
        %>
            <div class="text-muted">Bạn chưa có đánh giá nào cho sản phẩm này.</div>
        <%
            }
        %>
    </div>
</div>


        </div>
            
            
        <%@include file="Footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                // JavaScript để xử lý chọn màu sắc
                document.addEventListener('DOMContentLoaded', function () {
                    const colorOptions = document.querySelectorAll('.color-option');

                    colorOptions.forEach(option => {
                        option.addEventListener('click', function () {
                            // Bỏ chọn tất cả các màu khác
                            colorOptions.forEach(opt => opt.classList.remove('selected'));
                            // Chọn màu hiện tại
                            this.classList.add('selected');
                        });
                    });

                    // Chọn màu đầu tiên mặc định
                    if (colorOptions.length > 0) {
                        colorOptions[0].classList.add('selected');
                    }
                });
        </script>
    </body>
</html>