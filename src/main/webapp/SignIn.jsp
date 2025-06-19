<%-- 
    Document   : SignIn
    Created on : Jun 19, 2025, 7:55:59 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sign In - Smartphone retail management system</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Fredoka+One&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <style>
            body {
                background: #FFF8E7;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                font-family: 'Poppins', sans-serif;
                margin: 0;
            }
            .login-container {
                background: white;
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
                text-align: center;
                max-width: 400px;
                width: 100%;
/*                border-top: 6px solid #FF8800;*/
            }
            .lognin-container h2 {
                font-family: 'Fredoka One', cursive;
                color: #006400;
                margin-bottom: 20px;
                font-size: 32px;
            }
            .form-control {
                border-radius: 40px;
                padding: 12px;
                font-size: 14px;
                border: 2px solid #006400;
                transition: border-color 0.3s;
            }
            .form-control:focus {
                border-color: #66CC99;
                box-shadow: 0 0 7px rgba(255, 145, 77, 0.5);
            }
            .btn-login {
                background: linear-gradient(135deg, #00C853, #009688);
                color: white;
                border: none;
                padding: 12px;
                width: 100%;
                border-radius: 40px;
                font-size: 16px;
                font-weight: bold;
                transition: all 0.2s;
            }
            .btn-login:hover {
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
            .signup-link {
                margin-top: 15px;
                font-size: 15px;
            }
            .signup-link a {
                color: #006400;
                font-weight: bold;
                text-decoration: none;
            }
            .signup-link a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
                   
        <div class="login-container">
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

                <button type="submit" class="btn btn-login">Sign In</button>
                <a href="forgetpass" class="forgot-password">Forgot Password?</a>
            </form>
            <p class="signup-link">Don't have an account? <a href="signup">Sign Up</a></p>

            <%-- Notification --%>
            <div class="mt-3">
                <%
                    String error = (String) session.getAttribute("error");
                    String success = (String) session.getAttribute("success");
                    if (error != null) {
                %>
                <div class="alert alert-danger"><%= error%></div>
                <%
                    session.removeAttribute("error");
                } else if (success != null) {
                %>
                <div class="alert alert-success"><%= success%></div>
                <%
                        session.removeAttribute("success");
                    }
                %>
            </div>
        </div>
    </body>
</html>
