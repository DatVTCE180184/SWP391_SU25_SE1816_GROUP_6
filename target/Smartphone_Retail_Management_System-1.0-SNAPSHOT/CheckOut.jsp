<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String OrderCompletedOrNot = (String) request.getAttribute("OrderCompletedOrNot");
    boolean isSuccess = "completed".equals(OrderCompletedOrNot);
%>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .confirmation-box {
            background-color: #fff;
            padding: 50px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
        }

        .confirmation-box h2 {
            font-size: 28px;
            margin-bottom: 20px;
        }

        .confirmation-box p {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
        }

        .home-link {
            display: inline-block;
            text-decoration: none;
            color: white;
            background-color: #007bff;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .home-link:hover {
            background-color: #0056b3;
        }

        .success {
            color: #27ae60;
        }

        .fail {
            color: #e74c3c;
        }
    </style>
</head>
<body>

    <div class="confirmation-box">
        <% if (isSuccess) { %>
            <h2 class="success">✅ Thank you for your order!</h2>
            <p>Your order is being processed.</p>
            <a href="home" class="home-link">⬅ Back to Home</a>
        <% } else { %>
            <h2 class="fail">❌ Order Failed!</h2>
            <p>We're sorry, but your order could not be completed.<br>Please try again or contact support.</p>
            <a href="cart" class="home-link">⬅ Back to Cart</a>
        <% } %>
        
    </div>

</body>
</html>
