<%@ page import="java.util.*, model.CartItem" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
        cart = new ArrayList<>();
        cart.add(new CartItem(1, "OPPO Reno13 F", "img/reno13f.png", 1, 7990000));
        cart.add(new CartItem(2, "Huawei Watch Fit 4", "img/watchfit4.png", 2, 2790000));
        cart.add(new CartItem(3, "AirPods Pro 2", "img/airpodspro2.png", 1, 5990000));
        session.setAttribute("cart", cart);
    }
    double total = 0;
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Your Shopping Cart</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", sans-serif;
            background-color: #f4f4f4;
        }

        .cart-container {
            width: 90%;
            margin: 20px auto;
            background-color: #fff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #222;
            font-size: 28px;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: #ffcc00;
            color: #222;
            padding: 14px;
            text-transform: uppercase;
        }

        td {
            padding: 16px;
            border-bottom: 1px solid #eee;
            text-align: center;
            vertical-align: middle;
        }

        img {
            width: 70px;
            border-radius: 8px;
        }

        .quantity-btn {
            background-color: #ffcc00;
            border: none;
            padding: 6px 12px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 6px;
            transition: background-color 0.2s;
        }

        .quantity-btn:hover {
            background-color: #f0b400;
        }

        .remove-btn {
            background-color: #e74c3c;
            color: white;
            padding: 6px 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .remove-btn:hover {
            background-color: #c0392b;
        }

        .total {
            text-align: right;
            font-size: 20px;
            font-weight: bold;
            margin-top: 20px;
            color: #333;
        }

        .checkout-container {
            text-align: right;
            margin-top: 10px;
        }

        .checkout-btn {
            background-color: #27ae60;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .checkout-btn:hover {
            background-color: #219150;
        }

        .action-form {
            display: inline-block;
        }

        .empty-message {
            text-align: center;
            font-size: 18px;
            color: #888;
        }
    </style>
</head>
<body>

    <%-- ✅ Header --%>
    <jsp:include page="Header.jsp" />

    <div class="cart-container">
        <h2>🛒 Your Shopping Cart</h2>

        <%
            if (cart.isEmpty()) {
        %>
            <p class="empty-message">Your cart is currently empty.</p>
        <%
            } else {
        %>
        <table>
            <tr>
                <th>Image</th>
                <th>Product</th>
                <th>Unit Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
                <th>Action</th>
            </tr>

            <% for (CartItem item : cart) {
                double itemTotal = item.getPrice() * item.getQuantity();
                total += itemTotal;
            %>
            <tr>
                <td><img src="<%= item.getImage() %>" alt="<%= item.getName() %>" /></td>
                <td><%= item.getName() %></td>
                <td><%= String.format("%,.0f", item.getPrice()) %> ₫</td>
                <td>
                    <form class="action-form" action="cart" method="post">
                        <input type="hidden" name="action" value="decrease" />
                        <input type="hidden" name="id" value="<%= item.getId() %>" />
                        <button class="quantity-btn">−</button>
                    </form>

                    <strong><%= item.getQuantity() %></strong>

                    <form class="action-form" action="cart" method="post">
                        <input type="hidden" name="action" value="increase" />
                        <input type="hidden" name="id" value="<%= item.getId() %>" />
                        <button class="quantity-btn">+</button>
                    </form>
                </td>
                <td><%= String.format("%,.0f", itemTotal) %> ₫</td>
                <td>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="remove" />
                        <input type="hidden" name="id" value="<%= item.getId() %>" />
                        <button class="remove-btn">Remove</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>

        <div class="total">
            Total: <%= String.format("%,.0f", total) %> ₫
        </div>

        <div class="checkout-container">
            <form action="checkout.jsp" method="post">
                <button type="submit" class="checkout-btn">Check Out</button>
            </form>
        </div>

        <% } %>
    </div>

</body>
</html>
