<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.User"%>
<%
//   User acc = (User) session.getAttribute("user");
//   
//    User user = (User) session.getAttribute("user");
//    if (user == null) {
//        user = new User();
//    }
//    session.setAttribute("user", user);
//    
//    if (user.getRole_ID() == 3) {
//      session.setAttribute("redirectAfterLogin", "profile");
//        response.sendRedirect("signin?action=signin");
//        return;
//    }
//    
    User acc = (User) session.getAttribute("user");
    if (acc == null) {
        session.setAttribute("redirectAfterLogin", "profile");
        response.sendRedirect("signin?action=signin");
        return;
    }


%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Profile</title>
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <!-- FontAwesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />

        <link rel="stylesheet" href="./style/style.css" />

        <style>
            :root {
                --main-bg: #f8fafc;
                --main-primary: #FF6200;
                --main-accent: #ffc107;
                --main-sidebar: #f4f6fb;
                --main-text: #222;
                --main-text-secondary: #555;
            }
            body {
                background: var(--main-bg);
                color: var(--main-text);
            }
            .container-profile {
                display: flex;
                max-width: 1200px;
                margin: 40px auto;
                background: #fff;
                border-radius: 20px;
                box-shadow: 0 8px 32px rgba(0,0,0,0.10);
                overflow: hidden;
            }
            .sidebar {
                width: 250px;
                background: var(--main-sidebar);
                padding: 40px 0;
                border-right: 1px solid #e0e3e8;
                min-height: 100%;
            }
            .sidebar-menu a {
                display: flex;
                align-items: center;
                padding: 16px 36px;
                text-decoration: none;
                color: var(--main-text-secondary);
                border-radius: 0 30px 30px 0;
                margin-bottom: 10px;
                font-weight: 500;
                font-size: 1.1rem;
                transition: background 0.2s, color 0.2s, font-size 0.2s;
            }
            .sidebar-menu a.active, .sidebar-menu a:hover {
                background: var(--main-accent);
                color: var(--main-primary);
                font-size: 1.15rem;
            }
            .sidebar-menu a i {
                color: #555;
                margin-right: 14px;
            }
            .sidebar-menu a.active i, .sidebar-menu a:hover i {
                color: var(--main-primary);
            }
            .main-content {
                flex-grow: 1;
                padding: 48px 56px;
            }
            .main-content h1 {
                font-size: 2.3rem;
                color: var(--main-primary);
                margin-bottom: 32px;
                font-weight: 800;
            }
            .profile-form {
                display: flex;
                gap: 48px;
                justify-content: flex-start;
                align-items: flex-start;
            }
            .form-left {
                flex: 2;
            }
            .form-right {
                flex: 1;
                padding-left: 40px;
                border-left: 1px solid #e0e3e8;
                display: flex;
                flex-direction: column;
                align-items: flex-end;
                min-width: 320px;
            }
            .form-group label {
                font-weight: 700;
                color: var(--main-text-secondary);
                margin-bottom: 6px;
                font-size: 1.05rem;
            }
            .form-group input[type="text"],
            .form-group input[type="email"],
            .form-group input[type="password"] {
                width: 100%;
                padding: 14px 18px;
                border: 1.5px solid #cfd8dc;
                border-radius: 12px;
                margin-top: 4px;
                margin-bottom: 18px;
                font-size: 1.08rem;
                background: #f4f6fb;
                color: var(--main-text);
            }
            .form-group input:focus {
                border: 1.5px solid var(--main-primary);
                outline: none;
            }
            .btn-save {
                background: linear-gradient(135deg, var(--main-primary), #43cea2);
                color: white;
                padding: 14px 40px;
                border: none;
                border-radius: 30px;
                cursor: pointer;
                font-size: 1.15rem;
                font-weight: 700;
            }
            .btn-save:hover {
                background: linear-gradient(135deg, var(--main-accent), #ffe082);
                color: var(--main-primary);
            }
            .display-identity img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                margin-bottom: 14px;
                border: 4px solid var(--main-primary);
                object-fit: cover;
            }
            .display-identity .user-phone,
            .display-identity .user-name {
                text-align: right;
                font-weight: bold;
                color: #222;
                font-size: 1.08rem;
                width: 100%;
            }
        </style>
    </head>
    <body>
        <%@ include file="Header.jsp" %>
        <div class="container-profile">
            <div class="sidebar">
                <div class="sidebar-menu">
                    <a href="#"><i class="fas fa-box"></i> Your Orders</a>
                    <a href="#"><i class="fas fa-history"></i> Purchase History</a>
                    <a href="#" class="active"><i class="fas fa-user"></i> Personal Information</a>
                    <a href="#"><i class="fas fa-star"></i> Manage Reviews</a>
                    <a href="signin?action=logout" id="logout-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
            <div class="main-content">
                <h1>Update Profile</h1>
                <c:if test="${not empty message}">
                    <div class="message success">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="message error">${error}</div>
                </c:if>
                <form class="profile-form" action="profile" method="post">
                    <div class="form-left">
                        <div class="form-group">
                            <label for="username">Username:</label>
                            <input type="text" id="username" name="username" value="<%= acc.getUsername()%>">
                        </div>
                         <div class="form-group">
                            <label for="fullname">Full Name:</label>
                            <input type="text" id="fullname" name="fullname" value="<%= acc.getFullname()%>" placeholder="Enter your full name">
                        </div>
                        <div class="form-group">
                            <label>Gender:</label>
                            <div class="gender-options">
                                <label>
                                    <input type="radio" name="gender" value="1" <%= acc.getGender() == 1 ? "checked" : ""%>> Male
                                </label>
                                <label>
                                    <input type="radio" name="gender" value="2" <%= acc.getGender() == 2 ? "checked" : ""%>> Female
                                </label>
                                <label>
                                    <input type="radio" name="gender" value="3" <%= acc.getGender() == 3 ? "checked" : ""%>> Other
                                </label>
                            </div>
                        </div>
                       

                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" value="<%= acc.getEmail()%>" placeholder="Enter your email">
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone:</label>
                            <input type="text" id="phone" name="phone" value="<%= acc.getPhone()%>" placeholder="Enter your phone number">
                        </div>

                        <div class="form-group">
                            <label for="address">Address:</label>
                            <input type="text" id="address" name="address"  value="<%= acc.getAddress()%>" placeholder="Enter your address">
                        </div>
                        <hr>
                        <div class="form-group">
                            <label for="newPassword">New Password:</label>
                            <input type="password" id="newPassword" name="newPassword" placeholder="Leave blank if you do not want to change password">
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Confirm New Password:</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter new password">
                        </div>
                        <button type="submit" class="btn-save">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById('logout-link').addEventListener('click', function (event) {
                    if (!confirm('Are you sure you want to log out?')) {
                        event.preventDefault();
                    }
                });
            });
        </script>
    </body>
</html>