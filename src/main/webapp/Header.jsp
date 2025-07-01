<%-- 
    Document   : Header
    Created on : Jun 19, 2025, 8:33:18 PM
    Author     : ADMIN
--%>

<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<header class="container-fluid bg-warning py-3">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <!-- Logo -->
            <div class="container-logo">
                <a href="home">
                    <img alt="home" src="./img/logo2.png" alt="Logo" width="100" class="img-fluid" />
                </a>
            </div>

            <!-- Thanh tìm kiếm -->
            <div class="flex-grow-1 px-4">
                <form action="search" method="get" class="input-group">
                    <input type="hidden" name="from" value="SearchFilter" />
                    <input
                        type="text"
                        name="keyword"
                        class="form-control"
                        placeholder="Search for smartphones, brands, accessories..."
                        aria-label="Search"
                        required
                        />
                    <button class="btn btn-dark" type="submit">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </form>
            </div>

            <!-- Liên kết đăng nhập -->
            <div class="text-end d-flex align-items-center gap-3">
                <%
                    if (session.getAttribute("username") == null) {
                %> 
                <div>
                    <a href="signin?action=signin" class="btn btn-outline-light btn-sm me-2">
                        <i class="fa-solid fa-right-to-bracket"></i> Sign In
                    </a>
                    <a href="signup" class="btn btn-light btn-sm">
                        <i class="fa-solid fa-user-plus"></i> Sign Up
                    </a>
                </div>

                <%
                } else {


                %> 
                <div>
                    <a href="profile" class="btn btn-success" style="background:#ffffff; color: #000 ;border:none;">
                        Hello, <%= session.getAttribute("username")%>
                    </a>
                </div>

                <%
                    }

                %>

                <!--                         Nút tài khoản 
                                       
                                            <a href="profile" class="btn btn-warning">Account</a>
                                         Nút giỏ hàng 
                -->
                <a href="cart" class="btn btn-warning"> <i class="fa-solid fa-cart-shopping"></i> </a>


            </div>
        </div>
    </div>
</header>
