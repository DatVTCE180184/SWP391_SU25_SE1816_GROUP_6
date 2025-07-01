<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Interface</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
        <!-- Custom CSS -->
        <link rel="stylesheet" href="./style/style.css" />

        <style>
            body {
                margin: 0;
                padding: 0;
                background-color: #f0f0f0;
                font-family: Arial, sans-serif;
            }

            .admin-wrapper {
                display: flex;
                flex-direction: column;
                height: 100vh;
            }

            .admin-content {
                display: flex;
                flex: 1;
                overflow: hidden;
            }

            /* Sidebar styling */
            .sidebar {
                width: 250px;
                background-color: white;
                overflow-y: auto;
                padding: 20px 15px;
            }

            .menu-box {
                display: block;
                background-color: white;
                color: #333;
                padding: 12px 16px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 500;
                transition: 0.2s;
                margin: 0 10px 12px 15px;  /* 👈 đẩy menu vào phải */
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            }

            .menu-box:hover {
                background-color: #FFBF80; /* hover: cam nhạt */
                color: #000;
            }

            .menu-box.active {
                background-color: #E88C2D; /* active: cam đậm */
                color: white;
                font-weight: bold;
            }


            .content {
                flex-grow: 1;
                padding: 20px;
                background-color: #f9f9f9;
                overflow-y: auto;
            }

            header {
                flex-shrink: 0;
            }
        </style>
    </head>
    <body>
        <div class="admin-wrapper">
            <!-- Giữ nguyên Header -->
            <jsp:include page="Header.jsp" />

            <div class="admin-content">
                <!-- Sidebar dạng box -->
                <div class="sidebar">
                    <a class="menu-box ${section == 'Dashboard' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin?section=Dashboard">Dashboard</a>

                    <a class="menu-box ${section == 'Product Management (Products)' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin?section=Product Management (Products)">Product Management</a>

                    <a class="menu-box ${section == 'Category Management (Categories)' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin?section=Category Management (Categories)">Category Management</a>

                    <a class="menu-box ${section == 'Order Management (Orders)' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin?section=Order Management (Orders)">Order Management</a>

                    <a class="menu-box ${section == 'Payment Management (Payments)' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin?section=Payment Management (Payments)">Payment Management</a>

                    <a class="menu-box ${section == 'User Management (Users)' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin?section=User Management (Users)">User Management</a>

                    <a class="menu-box ${section == 'Customer Feedback (Feedbacks)' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin?section=Customer Feedback (Feedbacks)">Customer Feedback</a>
                </div>

                <!-- Nội dung chính -->
                <div class="content">
                    <c:choose>
                        <c:when test="${section == 'Dashboard'}">
                            <h2>Welcome to Dashboard</h2>
                            <p>Overview of your admin panel.</p>
                        </c:when>
                        <c:when test="${section == 'Product Management (Products)'}">
                            <h2>Product Management</h2>
                            <p>${productInfo}</p>
                        </c:when>
                        <c:when test="${section == 'Category Management (Categories)'}">
                            <h2>Category Management</h2>
                            <p>Manage categories here.</p>
                        </c:when>
                        <c:when test="${section == 'Order Management (Orders)'}">
                            <h2>Order Management</h2>
                            <p>Manage orders here.</p>
                        </c:when>
                        <c:when test="${section == 'Payment Management (Payments)'}">
                            <h2>Payment Management</h2>
                            <p>Manage payments here.</p>
                        </c:when>
                        <c:when test="${section == 'User Management (Users)'}">
                            <jsp:include page="User.jsp" />
                        </c:when>

                        <c:when test="${section == 'Customer Feedback (Feedbacks)'}">
                            <h2>Customer Feedback</h2>
                            <p>View feedbacks here.</p>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>
    </body>
</html>
s