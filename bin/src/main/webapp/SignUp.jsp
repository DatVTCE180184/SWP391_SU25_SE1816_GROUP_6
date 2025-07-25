<%-- 
    Document   : SignUp
    Created on : Jun 19, 2025, 10:16:08 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sign Up - Smartphone retail management system</title>
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
            .signup-container {
                background: white;
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
                text-align: center;
                max-width: 500px;
                width: 100%;
                /* border-top: 6px solid #FF8800; */
            }
            .signup-container h2 {
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
            .btn-signup {
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
            .btn-signup:hover {
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
            .signin-link {
                margin-top: 15px;
                font-size: 15px;
            }
            .signin-link a {
                color: #006400;
                font-weight: bold;
                text-decoration: none;
            }
            .signin-link a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        
        <div class="signup-container">
            <h2>SIGN UP</h2>
            <form id="signupForm" action="signup" method="post">

                <!-- Username -->
                <div class="mb-3">
                    <input type="text" id="username" class="form-control" name="username" placeholder="Username" required>
                    <div id="usernameError" class="error"></div>
                </div>

                <!-- Email -->
                <div class="mb-3">
                    <input type="email" id="email" class="form-control" name="email" placeholder="Email (@gmail.com only)" required>
                    <div id="emailError" class="error"></div>
                </div>

                <!-- Phone -->
                <div class="mb-3 row">
                    <div class="col-md-8">
                        <input type="text" id="phone" class="form-control" name="phone" placeholder="Phone (10 digits)" required>
                        <div id="phoneError" class="error"></div>
                    </div>
                </div>

                <!-- Address -->
                <div class="mb-3">
                    <input type="text" id="address" class="form-control" name="address" placeholder="Address" required>
                    <div id="addressError" class="error"></div>
                </div>

                <!-- Gender -->
                <div class="mb-3">
                    <label for="gender" class="form-label">Gender</label>
                    <select class="form-select" id="gender" name="gender_id" required>
                        <option value="">-- Select Gender --</option>
                        <option value="1">Male</option>
                        <option value="2">Female</option>
                        <option value="3">Other</option>
                    </select>
                </div>

                <!-- Password -->
                <div class="mb-3">
                    <input type="password" id="password" class="form-control" name="password" placeholder="Password" required>
                    <div id="passwordError" class="error"></div>
                </div>

                <!-- Confirm Password -->
                <div class="mb-3">
                    <input type="password" id="confirmPassword" class="form-control" name="confirmPassword" placeholder="Confirm Password" required>
                    <div id="confirmPasswordError" class="error"></div>
                </div>

                <div class="mb-3">
                    <label>Upload Avatar:</label>
                    <input type="file" class="form-control" name="avatar">
                </div>

                <button type="submit" class="btn btn-signup">Log In</button>
            </form>
            <p class="login-link">Already have an account? <a href="signin">Sign In</a></p>

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
