<%@ page contentType="text/html;charset=UTF-8" %>
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
                color: #27ae60;
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
        </style>
    </head>
    <body>
        <div class="confirmation-box">
            <h2>✅ Thank you for your order!</h2>
            <p>Your order is being processed.</p>
            <a href="HomePage.jsp" class="home-link">⬅ Back to Home</a>
        </div>

    </body>
</html>
