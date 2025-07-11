<%@page import="java.text.DecimalFormat"%>
<%@page import="model.User"%>
<%@ page import="java.util.*, model.CartItem" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    User acc = (User) session.getAttribute("user");
    if (acc == null) {
        session.setAttribute("redirectAfterLogin", "cart");
        response.sendRedirect("signin?action=signin");
    }
    ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");
    double total = 0;
     DecimalFormat df = new DecimalFormat("#,##0.00");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cart and Checkout</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Fredoka+One&family=Poppins:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    </head>
    <body class="bg-light">

        <div class="container py-5">
            <div class="container py-3">
                <a href="home" class="btn btn-outline-secondary">
                    ← Back 
                </a>
            </div>

            <div class="row g-4">

                <!-- Column 1: Cart -->
                <div class="col-lg-7">
                    <div class="card shadow-sm">
                        <div class="card-header bg-warning text-dark fw-bold fs-5">
                            🛒 Your Cart
                        </div>
                        <div class="card-body">
                            <% if (cart == null || cart.isEmpty()) { %>
                            <p class="text-center text-muted">Your cart is currently empty.</p>
                            <% } else { %>
                            <table class="table align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Image</th>
                                        <th>Product</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (CartItem item : cart) {
                                            double itemTotal = item.getPrice() * item.getQuantity();
                                            total += itemTotal;
                                    %>
                                    <tr>
                                        <td><img src="<%= item.getImage()%>" width="70" class="rounded"></td>
                                        <td><%= item.getName()%></td>
                                        <td><%= df.format(item.getPrice())%> $</td>
                                        <td>
                                            <form action="cart" method="post" class="d-inline">
                                                <input type="hidden" name="action" value="decrease">
                                                <input type="hidden" name="id" value="<%= item.getId()%>">
                                                <button class="btn btn-sm btn-outline-warning">−</button>
                                            </form>
                                            <strong><%= item.getQuantity()%></strong>
                                            <form action="cart" method="post" class="d-inline">
                                                <input type="hidden" name="action" value="increase">
                                                <input type="hidden" name="id" value="<%= item.getId()%>">
                                                <button class="btn btn-sm btn-outline-warning">+</button>
                                            </form>
                                        </td>
                                        <td><%= df.format(itemTotal)%> $</td>
                                        <td>
                                            <form action="cart" method="post">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="id" value="<%= item.getId()%>">
                                                <button class="btn btn-sm btn-danger">Remove</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                            <div class="text-end fw-bold fs-5">
                                Total: <%= df.format(total)%> $
                            </div>
                            <% }%>
                        </div>
                    </div>
                </div>

                <!-- Column 2: Order Form -->
                <% if (cart != null && !cart.isEmpty()) {%>
                <div class="col-lg-5">
                    <div class="card shadow-sm">
                        <div class="card-header bg-success text-white fw-bold fs-5">
                            Order Information
                        </div>
                        <div class="card-body">
                            <form action="order" method="post">

                                <input type="hidden" name="userId" value="<%= acc != null ? acc.getID() : ""%>">

                                <div class="mb-3">
                                    <label class="form-label">Full Name:</label>
                                    <input type="text" name="fullname" class="form-control" required value="<%= acc != null ? acc.getFullname(): ""%>">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Phone Number:</label>
                                    <input type="tel" name="phone" class="form-control" required value="<%= acc != null ? acc.getPhone() : ""%>">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Note:</label>
                                    <textarea name="note" class="form-control" rows="2"></textarea>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label fw-bold">Delivery Method</label>
                                    <div class="btn-group w-100 mb-3" role="group">
                                        <input type="radio" class="btn-check" name="Payment_Method" id="cod" value="COD">
                                        <label class="btn btn-outline-secondary w-50" for="cod">Home Delivery</label>

                                        <input type="radio" class="btn-check" name="Payment_Method" id="instore" value="InStore" checked>
                                        <label class="btn btn-outline-success w-50" for="instore">Store Pickup</label>
                                    </div>
                                </div>

                                <!-- Detailed Address Input -->
                                <div id="homeAddressFields" class="d-none">
                                    <div class="mb-3">
                                        <label class="form-label">Province / City:</label>
                                        <!--                                        <input type="text" name="province" class="form-control" placeholder="VD: TP. Hồ Chí Minh">-->
                                        <select id="provinces" class="form-control" name="province" onchange="getProvinces(event)" required>
                                            <option value="">-- Select province --</option>
                                        </select>
                                        <input type="hidden" name="provinceName" id="provinceName">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">District / County:</label>
                                        <!--                                        <input type="text" name="district" class="form-control" placeholder="VD: Quận 1">-->
                                        <select id="districts" class="form-control" name="district" onchange="getDistricts(event)" required>
                                            <option value="">-- Select district--</option>
                                        </select>
                                        <input type="hidden" name="districtName" id="districtName">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Ward / Commune:</label>
                                        <select id="wards" class="form-control" name="ward" required>
                                            <option value="">-- Select ward --</option>
                                        </select>
                                        <input type="hidden" name="wardName" id="wardName">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Street / House Number:</label>
                                        <input type="text" name="street" class="form-control" placeholder="Ex: 123 Nguyen Trai">
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-success w-100 fw-bold py-2" >Confirm and Place Order</button>
                            </form>
                        </div>
                    </div>
                </div>
                <% }%>
            </div>
        </div>

        <script>
            const homeRadio = document.getElementById('cod');
            const storeRadio = document.getElementById('instore');
            const addressFields = document.getElementById('homeAddressFields');

            function toggleAddressFields() {
                if (homeRadio.checked) {
                    addressFields.classList.remove('d-none');

                    // Bật required khi nhận tại nhà
                    document.getElementById("provinces").setAttribute("required", "required");
                    document.getElementById("districts").setAttribute("required", "required");
                    document.getElementById("wards").setAttribute("required", "required");
                } else {
                    addressFields.classList.add('d-none');
                    // Tắt required khi nhận tại cửa hàng
                    document.getElementById("provinces").removeAttribute("required");
                    document.getElementById("districts").removeAttribute("required");
                    document.getElementById("wards").removeAttribute("required");
                }
            }

            homeRadio.addEventListener('change', toggleAddressFields);
            storeRadio.addEventListener('change', toggleAddressFields);

            // Gọi lần đầu khi load trang
            window.addEventListener('DOMContentLoaded', toggleAddressFields);

            document.querySelector("form").addEventListener("submit", function (e) {
                const province = document.getElementById("provinces");
                const district = document.getElementById("districts");
                const ward = document.getElementById("wards");

                const provinceName = province.options[province.selectedIndex].text;
                const districtName = district.options[district.selectedIndex].text;
                const wardName = ward.options[ward.selectedIndex].text;

                document.getElementById("provinceName").value = removeVietnameseTones(provinceName);
                document.getElementById("districtName").value = removeVietnameseTones(districtName);
                document.getElementById("wardName").value = removeVietnameseTones(wardName);
            });

            function removeVietnameseTones(str) {
                str = str.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
                str = str.replace(/đ/g, "d").replace(/Đ/g, "D");
                return str;
            }
        </script>

        <script src="LocationJS.js"></script>

    </body>
</html>
