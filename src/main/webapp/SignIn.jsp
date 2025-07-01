<%-- 
    Document   : login
    Created on : Feb 27, 2025, 9:01:02 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sign In - Smartphone retail management system</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Fredoka+One&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <style>
            body {
                background: #FFF8E7;
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
            }

            .main-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                min-height: 100vh;
                padding-top: 100px; /* khoảng cách dưới header */
            }

            .signIn-container {
                background: white;
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
                text-align: center;
                max-width: 500px;
                width: 100%
            }

            .signIn-container h2 {
                font-family: 'Fredoka One', cursive;
                color: #ffc107;
                margin-bottom: 20px;
                font-size: 32px;
            }

            .form-control {
                border-radius: 40px;
                padding: 12px;
                font-size: 14px;
                border: 2px solid #ffc107;
                transition: border-color 0.3s;
            }

            .form-control:focus {
                border-color: #66CC99;
                box-shadow: 0 0 7px rgba(255, 145, 77, 0.5);
            }

            .btn-signIn {
                background: linear-gradient(135deg, #00C853, #ffc107);
                color: white;
                border: none;
                padding: 12px;
                width: 100%;
                border-radius: 40px;
                font-size: 16px;
                font-weight: bold;
                transition: all 0.2s;
            }

            .btn-signIn:hover {
                background: linear-gradient(135deg, #FF6200, #E65100);
                box-shadow: 0 5px 12px rgba(255, 98, 0, 0.35);
                transform: scale(1.07);
            }

            .error {
                color: red;
                font-size: 14px;
                text-align: left;
                margin-top: 5px;
            }

            .signUp-link {
                margin-top: 15px;
                font-size: 15px;
            }

            .signUp-link a {
                color: #ffc107;
                font-weight: bold;
                text-decoration: none;
            }

            .signUp-link a:hover {
                text-decoration: underline;
            }

            .forget-password {
                display: block;
                margin-top: 10px;
                font-size: 14px;
                color: #555;
                text-decoration: none;
            }

            .forget-password:hover {
                text-decoration: underline;
                color: #ffc107;
            }
        </style>
    </head>
    <body>
        <%@include file="Header.jsp"%>

        <div class="main-container">
            <div class="signIn-container">
                <h2>Sign In</h2>
                <form id="SignInForm" action="signin" method="post">

                    <!-- Username -->
                    <div class="mb-3">
                        <input type="text" id="username" class="form-control" name="username" placeholder="Username" required>
                        <div id="usernameError" class="error"></div>
                    </div>

                    <!-- Password -->
                    <div class="mb-3">
                        <input type="password" id="password" class="form-control" name="password" placeholder="Password" required>
                        <div id="passwordError" class="error"></div>
                    </div>

                    <button type="submit" class="btn btn-signIn">Sign In</button>
                    <a href="forgetpass" class="forget-password">Forget Password?</a>
                </form>

                <p class="signUp-link">Don't have an account? <a href="signup">Sign Up</a></p>

                <!-- Notification -->
                <div class="mt-3">
                    <%
                        String error = (String) session.getAttribute("error");
                        String success = (String) session.getAttribute("success");
                        if (error != null) {
                    %>
                    <div class="alert alert-danger"><%= error %></div>
                    <%
                        session.removeAttribute("error");
                    } else if (success != null) {
                    %>
                    <div class="alert alert-success"><%= success %></div>
                    <%
                        session.removeAttribute("success");
                        }
                    %>
                </div>
            </div>
        </div>
    </body>
</html>
