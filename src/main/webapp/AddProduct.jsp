<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-4">
    <h2>Add New Product</h2>
    <form action="product" method="post">
        <input type="hidden" name="action" value="add"/>
        <div class="mb-3">
            <label class="form-label">Product Name</label>
            <input name="pro_Name" class="form-control" required />
        </div>
        <div class="mb-3">
            <label class="form-label">Category</label>
            <select name="cat_ID" class="form-select" required>
                <c:forEach var="cat" items="${list_Category}">
                    <option value="${cat.cat_ID}">${cat.cat_Name}</option>
                </c:forEach>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Price</label>
            <input name="pro_Price" type="number" step="0.01" class="form-control" required />
        </div>
        <div class="mb-3">
            <label class="form-label">Quantity</label>
            <input name="pro_Quantity" type="number" class="form-control" required />
        </div>
        <div class="mb-3">
            <label class="form-label">Status</label>
            <select name="pro_Status" class="form-select">
                <option value="1">Active</option>
                <option value="0">Inactive</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Image URL</label>
            <input name="pro_Image" class="form-control" />
        </div>
        <div class="mb-3">
            <label class="form-label">Colors</label>
            <input name="pro_Colors" class="form-control" />
        </div>
        <div class="mb-3">
            <label class="form-label">Specs</label>
            <input name="pro_Specs" class="form-control" />
        </div>
        <div class="mb-3">
            <label class="form-label">Detail Image URL</label>
            <input name="pro_Detail_Image" class="form-control" />
        </div>
        <button type="submit" class="btn btn-success">Add Product</button>
        <a href="product?action=admin" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html> 