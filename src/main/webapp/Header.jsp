<%-- 
    Document   : Header
    Created on : Jun 19, 2025, 8:33:18 PM
    Author     : ADMIN
--%>

<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
    
        user = new User();
    }
    session.setAttribute("user", user);
    
    
//    String action = request.getParameter("action");
//    if (action == null) {
//        action = "signin";
//    }


%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <!-- Custom CSS -->
        <link rel="stylesheet" href="./style/style.css" />
        <!-- Font Awesome -->

        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    </head>
    <body>
        <header class="container-fluid bg-warning py-3">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <!-- Logo -->
                    <div class="container-logo">
                        <img alt="home" src="./img/logo2.png" alt="Logo" width="100" class="img-fluid" />
                    </div>

                    <!-- Thanh tìm kiếm -->
                    <div class="flex-grow-1 px-4">
                        <form action="search" method="get" class="input-group">
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
                        <%                            if (user.getRole_ID() == 0) {
                        %> 
                        <div>
                            <a href="signin?action=signin" class="text-white text-decoration-none">Sign In</a>
                            <span class="text-white px-1">|</span>
                            <a href="signup" class="text-white text-decoration-none">Sign Up</a>
                        </div>

                        <%
                            } else if (user.getRole_ID() == 3) {


                        %> 
                         <div>
                            <a href="profile" class="text-white text-decoration-none">Hello, <%= user.getUsername() %>! </a>
                            <span class="text-white px-1">|</span>
                            <a href="signin?action=logout" class="text-white text-decoration-none">Log Out</a>
                        </div>
                        
                        <%
                            }
                        
                        %>

                        <!-- Nút tài khoản -->
                       
                            <a href="profile" class="btn btn-warning">Account</a>
                        <!-- Nút giỏ hàng -->
                       
                        <a href="cart" class="btn btn-warning"> <i class="fa-solid fa-cart-shopping"></i> </a>
                       
                       
                    </div>
                </div>
            </div>
        </header>
    </body>
</html>
