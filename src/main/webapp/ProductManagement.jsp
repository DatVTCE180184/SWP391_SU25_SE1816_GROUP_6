<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <div class="container mt-4">
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
                    <option value="0" <c:if test="${param.status == '0'}">selected</c:if>>Hidden</option>
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
                        <td><img src="${product.pro_Image}" alt="Image" style="width:50px;height:50px;object-fit:cover;"/></td>
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
    </div>
</body>
</html> 