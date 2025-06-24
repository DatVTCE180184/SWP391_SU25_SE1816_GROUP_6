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
        <meta charset="UTF-8">
        <title>Trang chủ</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <!-- Custom CSS -->
        <link rel="stylesheet" href="./style/style.css" />
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    </head>

    <body>
        <!-- HEADER -->
        <!--        <header class="container-fluid bg-warning py-3">
                    <div class="container">
                        <div class="d-flex justify-content-between align-items-center">
                             Logo 
                            <div class="container-logo">
                                <img src="./img/logo2.png" alt="Logo" width="100" class="img-fluid" />
                            </div>
        
                             Thanh tìm kiếm 
                            <div class="flex-grow-1 px-4">
                                <div class="input-group">
                                    <input
                                        type="text"
                                        class="form-control"
                                        placeholder="Hôm nay bạn muốn tìm kiếm gì?" />
                                    <button class="btn btn-warning">
                                        <i class="fa-solid fa-magnifying-glass"></i>
                                    </button>
                                </div>
                            </div>
        
                             Liên kết đăng nhập 
                            <div class="text-end d-flex align-items-center gap-3">
                                <div>
                                    <a href="signin" class="text-white text-decoration-none">Sign In</a>
                                    <span class="text-white px-1">|</span>
                                    <a href="signup" class="text-white text-decoration-none">Sign Up</a>
                                </div>
                                 Nút tài khoản 
                                <button class="btn btn-warning">Account</button>
                                 Nút giỏ hàng 
                                <button class="btn btn-warning">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </header>-->
        <%@include file="Header.jsp" %>
        <!-- NAV + CAROUSEL -->
        <div class="search-sugget">
            <ul>
                <strong>Trending keywords:</strong>
                <li><a href="#">Iphone 15</a></li>
                <li><a href="#">Samsung</a></li>
                <li><a href="#">Laptop</a></li>
                <li><a href="#">Accessories</a></li>
            </ul>
        </div>

        <div class="container mt-4">
            <div class="row">
                <!-- Cột trái: Nút Danh mục -->
                <div class="col-md-3 mb-2">
                    <button class="btn btn-warning w-100" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasMenu" aria-controls="offcanvasMenu">
                        ☰ Menu
                    </button>
                </div>

                <!-- Cột phải: Carousel -->
                <div class="col-md-9">
                    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                        <!-- Chấm chuyển slide -->
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                        </div>

                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <div class="carousel-image-wrapper">
                                    <img src="./img/1.png" class="d-block w-100" alt="Slide 1">
                                </div>
                            </div>
                            <div class="carousel-item">
                                <div class="carousel-image-wrapper">
                                    <img src="./img/2.png" class="d-block w-100" alt="Slide 2">
                                </div>
                            </div>
                            <div class="carousel-item">
                                <div class="carousel-image-wrapper">
                                    <img src="./img/3.png" class="d-block w-100" alt="Slide 3">
                                </div>
                            </div>
                        </div>

                        <!-- Nút điều khiển -->
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Trước</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Sau</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Offcanvas Menu -->
        <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasMenu" aria-labelledby="offcanvasMenuLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasMenuLabel">Menu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Đóng"></button>
            </div>
            <div class="offcanvas-body">

                <% if (list_Cat == null) {
                        out.println("No Data!");
                    } else {
                %>
                <ul class="list-unstyled">
                    <%            for (Category cat : list_Cat) {
                    %>
                    <li class="d-flex align-items-center mb-3">
                        <img src="./img/icon-dienthoai.png" alt="Điện thoại" class="me-2 rounded-circle" width="32" height="32" />
                        <span><%= cat.getCat_Name()%></span>
                    </li>
                    <%
                        }
                    %>
                    <!--        <li class="d-flex align-items-center mb-3">
                              <img src="./img/icon-dienthoai.png" alt="Điện thoại" class="me-2 rounded-circle" width="32" height="32" />
                              <span>Smartphone</span>
                            </li>
                            <li class="d-flex align-items-center mb-3">
                              <img src="./img/icon-apple.png" alt="Apple" class="me-2 rounded-circle" width="32" height="32" />
                              <span>Apple</span>
                            </li>-->
                </ul>
                <%
                    }
                %>
            </div>
        </div>
        <section class="container my-5">
            <% if (list_Cat == null) {
                    out.println("No Data!");
                } else {
            %>

            <div class="row row-cols-1 row-cols-md-4 g-4">

                <%          for (Product pro : list_Pro) {
                %>
                <a href="product?action=details&id=<%= pro.getPro_ID() %>">
                    <div class="col">
                    <div class="card h-100 shadow">
                        <img src="./img/9.png" class="card-img-top" alt="..." />
                        <div class="card-body">
                            <h5 class="card-title"><%= pro.getPro_Name()%></h5>
                            <p class="card-text"><%= pro.getPro_Description()%></p>
                            <strong style="color: red"><%= pro.getPro_Price()%> </strong>
                        </div>
                        <div class="card-footer">
                            <form action="cart" method="post">
                                <input type="hidden" name="action" value="add" />
                                <input type="hidden" name="id" value="<%= pro.getPro_ID()%>" />
                                <input type="hidden" name="name" value="<%= pro.getPro_Name()%>" />
                                <input type="hidden" name="image" value="<%= pro.getPro_Image()%>" />
                                <input type="hidden" name="price" value="<%= pro.getPro_Price()%>" />
                                <input type="hidden" name="quantity" value="1" />
                                <button type="submit" class="btn btn-warning w-100">🛒 Add to Cart</button>
                            </form>
<!--                            <button type="submit"  class="btn btn-warning w-100">Buy now</button>-->
                        </div>
                    </div>
                </div>
                    
                </a>
                
                <%
                    }
                %>

                <%
                    }
                %>

        </section>

        <!-- Footer-->
        <footer class="bg-light py-4">
            <div class="container">

                <!-- Row 1: Thông tin & Liên hệ -->
                <div class="row mb-4">
                    <!-- Cột: Thông tin và chính sách -->
                    <div class="col-md-6 col-lg-4 mb-3">
                        <h5 class="fw-bold">Thông tin và chính sách</h5>
                        <ul class="list-unstyled">
                            <li><a href="#">Mua hàng và thanh toán Online</a></li>
                            <li><a href="#">Mua hàng trả góp Online</a></li>
                            <li><a href="#">Mua hàng trả góp bằng thẻ tín dụng</a></li>
                            <li><a href="#">Chính sách giao hàng</a></li>
                            <li><a href="#">Chính sách đổi trả</a></li>
                        </ul>
                    </div>

                    <!-- Cột: Liên hệ -->
                    <div class="col-md-6 col-lg-4 mb-3">
                        <h5 class="fw-bold">Contact</h5>
                        <ul class="list-unstyled">
                            <li>
                                <a href="https://www.facebook.com/" target="_blank">
                                    <i class="fa-brands fa-facebook me-2"></i>Facebook
                                </a>
                            </li>
                            <li>
                                <a href="https://zalo.me/" target="_blank">
                                    <i class="fa-solid fa-comment-dots me-2"></i>Zalo
                                </a>
                            </li>
                            <li>
                                <a href="https://www.facebook.com/yourfanpage" target="_blank">
                                    <i class="fa-solid fa-globe me-2"></i>Fanpage
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                <hr>

                <!-- Row 2: Liên kết sản phẩm -->
                <div class="row">
                    <div class="col">
                        <div class="footer-link small text-secondary">
                            <a href="#">Điện thoại iPhone 15</a> |
                            <a href="#">Điện thoại iPhone 16</a> |
                            <a href="#">Điện thoại giá rẻ</a> |
                            <a href="#">Điện thoại iPhone</a> |
                            <a href="#">Xiaomi</a> |
                            <a href="#">Laptop</a> |
                            <a href="#">Laptop Acer</a> |
                            <a href="#">Laptop Dell</a> |
                            <a href="#">Laptop HP</a> | 
                            <a href="#">Build PC</a> |
                            <a href="#">Điện thoại iPhone 16 Pro Max</a> |
                            <a href="#">Điện thoại Samsung Galaxy</a> |
                            <a href="#">Điện thoại OPPO</a> |


                        </div>
                    </div>
                </div>

            </div>
        </footer>



        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
