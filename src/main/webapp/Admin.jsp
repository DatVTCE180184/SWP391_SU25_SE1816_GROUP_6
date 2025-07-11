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
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet" />
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
                       href="${pageContext.request.contextPath}/product?section=Product Management (Products)&action=admin">Product Management</a>

                    <a class="menu-box ${section == 'Category Management (Categories)' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin?section=Category Management (Categories)">Category Management</a>

                    <a class="menu-box ${section == 'Order Management (Orders)' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin?section=Order Management (Orders)">Order Management</a>

                    <a class="menu-box ${section == 'Payment Management (Payments)' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin?section=Payment Management (Payments)">Payment Management</a>

                    <a class="menu-box ${section == 'User_List' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/user?action=list&section=User_List">User Management</a>

                    <a class="menu-box ${section == 'Customer Feedback (Feedbacks)' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/admin?section=Customer Feedback (Feedbacks)">Customer Feedback</a>
                </div>

                <!-- Nội dung chính -->
                <div class="content">
                    <c:choose>
                        <c:when test="${section == 'Dashboard'}">
                            <h2>Overview Dashboard</h2>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="card text-white bg-primary mb-3">
                                        <div class="card-header">Total Products</div>
                                        <div class="card-body">
                                            <h5 class="card-title">${totalProducts}</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card text-white bg-success mb-3">
                                        <div class="card-header">Total Users</div>
                                        <div class="card-body">
                                            <h5 class="card-title">${totalUsers}</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card text-white bg-warning mb-3">
                                        <div class="card-header">Total Orders</div>
                                        <div class="card-body">
                                            <h5 class="card-title">${totalOrders}</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card text-white bg-danger mb-3">
                                        <div class="card-header">Total Revenue</div>
                                        <div class="card-body">
                                            <h5 class="card-title">${totalRevenue} USD</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Order Status Statistics -->
                            <h4 class="mt-4">Order Status Statistics</h4>
                            <div class="row">
                                <c:forEach var="entry" items="${orderStatusStats}">
                                    <div class="col-md-2">
                                        <div class="card mb-2">
                                            <div class="card-header">${entry.key}</div>
                                            <div class="card-body">
                                                <h5 class="card-title">${entry.value}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <!-- Top Selling Products -->
                            <h4 class="mt-4">Top 5 Best Selling Products</h4>
                            <table class="table table-striped">
                                <thead>
                                    <tr><th>Product</th><th>Quantity Sold</th></tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="prod" items="${topSellingProducts}">
                                        <tr>
                                            <td>${prod.name}</td>
                                            <td>${prod.sold}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <!-- Revenue Chart -->
                            <h4 class="mt-4">Revenue for Last 6 Months</h4>
                            <canvas id="revenueChart"></canvas>
                            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                            <script>
                                var ctx = document.getElementById('revenueChart').getContext('2d');
                                var labels = [
                                <c:forEach var="entry" items="${monthlyRevenue}">
                                    '${entry.key}',
                                </c:forEach>
                                ];
                                var data = [
                                <c:forEach var="entry" items="${monthlyRevenue}">
                                    ${entry.value},
                                </c:forEach>
                                ];
                                new Chart(ctx, {
                                    type: 'line',
                                    data: {
                                        labels: labels,
                                                                            datasets: [{
                                            label: 'Revenue',
                                            data: data,
                                                borderColor: 'rgba(75, 192, 192, 1)',
                                                fill: false
                                            }]
                                    }
                                });
                            </script>
                        </c:when>
                        <c:when test="${section == 'Product Management (Products)'}">
                            <h2 class="text-center mb-4" style="font-size:2.5rem;font-weight:bold;letter-spacing:1px;"><i class="fa fa-cubes me-2"></i>Product Management</h2>
                            <form class="row mb-3" method="get" action="product">
                                <input type="hidden" name="action" value="admin"/>
                                <div class="col">
                                    <input type="text" name="keyword" class="form-control" placeholder="Search by product name..." value="${param.keyword}"/>
                                </div>
                                <div class="col">
                                    <select name="cat_ID" class="form-select">
                                        <option value="">All Categories</option>
                                        <c:forEach var="cat" items="${list_Category}">
                                            <option value="${cat.cat_ID}" <c:if test="${param.cat_ID == cat.cat_ID}">selected</c:if>>${cat.cat_Name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col">
                                    <select name="status" class="form-select">
                                        <option value="">All Status</option>
                                        <option value="1" <c:if test="${param.status == '1'}">selected</c:if>>Active</option>
                                        <option value="0" <c:if test="${param.status == '0'}">Hidden</option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <button type="submit" class="btn btn-info">Filter</button>
                                    </div>
                                </form>
                                <a href="product?action=addForm" class="btn btn-primary mb-3">Add New Product</a>
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Category</th>
                                            <th>Image</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="product" items="${list_Product}">
                                        <tr>
                                            <td>${product.pro_ID}</td>
                                            <td>${product.pro_Name}</td>
                                            <td>${product.cat_Name}</td>
                                            <td><img src="${product.pro_Image}" alt="Ảnh" style="width:50px;height:50px;object-fit:cover;"/></td>
                                            <td>${product.pro_Price}</td>
                                            <td>${product.pro_Quantity}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${product.pro_Status}">
                                                        <span class="badge bg-success">Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Hidden</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${product.pro_Status}">
                                                        <a href="product?action=toggleStatus&id=${product.pro_ID}&status=true" class="btn btn-sm btn-secondary">Hide</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="product?action=toggleStatus&id=${product.pro_ID}&status=false" class="btn btn-sm btn-success">Show</a>
                                                    </c:otherwise>
                                                </c:choose>
                                                <a href="product?action=editForm&id=${product.pro_ID}" class="btn btn-sm btn-warning">Edit</a>
                                                <a href="product?action=delete&id=${product.pro_ID}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this product?');">Delete</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
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
                        <c:when test="${section == 'User_List' || action == 'list'}">
                            <h2>User Management</h2>
                            
                            <!-- Success/Error Messages -->
                            <c:if test="${not empty param.successMsg}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fa fa-check-circle me-2"></i>${param.successMsg}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            <c:if test="${not empty param.errorMsg}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fa fa-exclamation-triangle me-2"></i>${param.errorMsg}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            
                            <div class="mb-2 text-end">
                                <a class="btn btn-success" href="user?action=create"><i class="bi bi-file-earmark-plus"></i> Create</a>
                            </div>
                            <table class="table table-bordered table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th> <!-- ??i tên c?t -->
                                        <th>Username</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Address</th>
                                        <th>Gender</th>
                                        <th>Role</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="u" items="${users}" varStatus="status">
                                        <tr>
                                            <td>${u.ID}</td>
                                            <td>${u.username}</td>
                                            <td>${u.email}</td>
                                            <td>${u.phone}</td>
                                            <td>${u.address}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.gender == 1}">Male</c:when>
                                                    <c:when test="${u.gender == 2}">Female</c:when>
                                                    <c:otherwise>Other</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.role_ID == 2}">Staff</c:when>
                                                    <c:otherwise>Customer</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="user?action=update&id=${u.ID}" class="btn btn-primary"><i class="bi bi-tools"></i> Edit</a>
                                                <a href="user?action=delete&id=${u.ID}" class="btn btn-danger"><i class="bi bi-trash"></i> Delete</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:when test="${section == 'Customer Feedback (Feedbacks)'}">
                            <h2>Customer Feedback</h2>
                            <p>View feedbacks here.</p>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>
        
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>