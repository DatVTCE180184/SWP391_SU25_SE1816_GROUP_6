<%-- Document : HomePage Created on : Jun 16, 2025, 10:04:20 AM Author : ADMIN --%>

<%@page import="model.Category" %>
<%@page import="java.util.List" %>
<%@page import="model.Product" %>
<%@page import="model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="dao.ProductDao" %>
<% User acc = (User) session.getAttribute("user");
    if (acc == null) {
        acc = new User();
        session.setAttribute("user", acc);
    }
    List<Product> list_Pro = (List<Product>) request.getAttribute("list_Product");
    List<Category> list_Cat = (List<Category>) request.getAttribute("list_Category");


%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>Home</title>

        <!-- Bootstrap -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet" />
        <!-- Custom CSS -->
        <link rel="stylesheet" href="./style/style.css" />
        <!-- Font Awesome -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
            rel="stylesheet" />

    </head>

    <body>
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
                <!-- Left Column: Category Button -->
                <div class="col-md-3 mb-2">
                    <button class="btn btn-warning w-100" type="button"
                            data-bs-toggle="offcanvas"
                            data-bs-target="#offcanvasMenu"
                            aria-controls="offcanvasMenu">
                        ☰ Menu
                    </button>
                </div>

                <!-- Right Column: Carousel -->
                <div class="col-md-9">
                    <div id="carouselExampleIndicators"
                         class="carousel slide" data-bs-ride="carousel">
                        <!-- Slide indicators -->
                        <div class="carousel-indicators">
                            <button type="button"
                                    data-bs-target="#carouselExampleIndicators"
                                    data-bs-slide-to="0" class="active"
                                    aria-current="true"
                                    aria-label="Slide 1"></button>
                            <button type="button"
                                    data-bs-target="#carouselExampleIndicators"
                                    data-bs-slide-to="1"
                                    aria-label="Slide 2"></button>
                            <button type="button"
                                    data-bs-target="#carouselExampleIndicators"
                                    data-bs-slide-to="2"
                                    aria-label="Slide 3"></button>
                        </div>

                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <div class="carousel-image-wrapper">
                                    <img src="./img/1.png"
                                         class="d-block w-100" alt="Slide 1">
                                </div>
                            </div>
                            <div class="carousel-item">
                                <div class="carousel-image-wrapper">
                                    <img src="./img/2.png"
                                         class="d-block w-100" alt="Slide 2">
                                </div>
                            </div>
                            <div class="carousel-item">
                                <div class="carousel-image-wrapper">
                                    <img src="./img/3.png"
                                         class="d-block w-100" alt="Slide 3">
                                </div>
                            </div>
                        </div>

                        <!-- Control buttons -->
                        <button class="carousel-control-prev" type="button"
                                data-bs-target="#carouselExampleIndicators"
                                data-bs-slide="prev">
                            <span class="carousel-control-prev-icon"
                                  aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button"
                                data-bs-target="#carouselExampleIndicators"
                                data-bs-slide="next">
                            <span class="carousel-control-next-icon"
                                  aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Offcanvas Menu -->
        <div class="offcanvas offcanvas-start" tabindex="-1"
             id="offcanvasMenu" aria-labelledby="offcanvasMenuLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasMenuLabel">Menu
                </h5>
                                 <button type="button" class="btn-close"
                         data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">

                <% if (list_Cat == null) {
                        out.println("No Data!");
                    } else {
                %>
                <ul class="list-unstyled">
                    <% for (Category cat : list_Cat) {%>
                    <li class="d-flex align-items-center mb-3">

                                                                            <!--                        <span><%= cat.getCat_Name()%></span>-->

                        <a style="text-decoration: none; font-family: 'Poppins'; color: #333"
                           href="search?from=Product_by_Category&keyword=<%= cat.getCat_Name()%>">
                            <i
                                class="fa-solid <%= cat.getCat_img()%> me-2 fs-5"></i>
                            <%= cat.getCat_Name()%>
                        </a>
                    </li>
                    <% } %>

                    <% } %>
            </div>
        </div>
        <section class="container my-5">
            <% if (list_Pro == null) {
                    out.println("No Data!");
                } else { %>

            <div
                class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                <% for (Product pro : list_Pro) {%>
                <div class="col d-flex align-items-stretch">
                    <div
                        class="card h-100 shadow-sm border-0 product-card">
                        <!-- Product Image -->
                        <div class="product-image-container">

                            <img src="<%= pro.getPro_Image()%>"
                                 class="card-img-top product-image"
                                 alt="<%= pro.getPro_Name()%>" />

                        </div>

                        <!-- Product Info -->
                        <div
                            class="card-body d-flex flex-column p-3">

                            <h6 class="card-title mb-2 text-truncate"
                                title="<%= pro.getPro_Name()%>">
                                <%= pro.getPro_Name()%>
                            </h6>


                            <p class="card-text flex-grow-1 small text-muted mb-2"
                               style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                <%= pro.getPro_Description()%>
                            </p>
                            <div class="price-section mb-3">
                                <strong class="text-danger fs-5">$
                                    <%= pro.getPro_Price()%>
                                </strong>
                            </div>
                        </div>

                        <!-- View Details Button -->
                        <div
                            class="card-footer bg-white border-0 pt-0">
                            <a href="product?action=details&id=<%= pro.getPro_ID()%>"
                               class="btn btn-primary w-100 py-2 text-decoration-none" style="background-color: #0D47A1;">
                                <i class="fa fa-eye me-2"></i>View Details
                            </a>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% }%>

        </section>

        <!-- Footer-->
        <%@include file="Footer.jsp" %>

        <!-- Bootstrap JS -->
        <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>