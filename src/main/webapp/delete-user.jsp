<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete User Confirmation</title>
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow border-danger">
                        <div class="card-header bg-danger text-white">
                            <h3 class="mb-0">
                                <i class="fa fa-exclamation-triangle me-2"></i>Confirm User Deletion
                            </h3>
                        </div>
                        <div class="card-body">
                            <div class="alert alert-warning" role="alert">
                                <i class="fa fa-warning me-2"></i>
                                <strong>Warning:</strong> This action cannot be undone. The user will be permanently deleted from the system.
                            </div>
                            
                            <h5 class="mb-3">User Information to be Deleted:</h5>
                            
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <tbody>
                                        <tr>
                                            <th class="bg-light" style="width: 30%;">User ID:</th>
                                            <td>${user.ID}</td>
                                        </tr>
                                        <tr>
                                            <th class="bg-light">Username:</th>
                                            <td>${user.username}</td>
                                        </tr>
                                        <tr>
                                            <th class="bg-light">Full Name:</th>
                                            <td>${user.fullname}</td>
                                        </tr>
                                        <tr>
                                            <th class="bg-light">Email:</th>
                                            <td>${user.email}</td>
                                        </tr>
                                        <tr>
                                            <th class="bg-light">Phone:</th>
                                            <td>${user.phone}</td>
                                        </tr>
                                        <tr>
                                            <th class="bg-light">Address:</th>
                                            <td>${user.address}</td>
                                        </tr>
                                        <tr>
                                            <th class="bg-light">Gender:</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.gender == 1}">Male</c:when>
                                                    <c:when test="${user.gender == 2}">Female</c:when>
                                                    <c:otherwise>Other</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="bg-light">Role:</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.role_ID == 1}">Admin</c:when>
                                                    <c:when test="${user.role_ID == 2}">Staff</c:when>
                                                    <c:when test="${user.role_ID == 3}">Customer</c:when>
                                                    <c:otherwise>Unknown</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            <form action="user?action=delete" method="post" class="mt-4">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${user.ID}">
                                
                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-danger" onclick="return confirm('Are you absolutely sure you want to delete this user? This action cannot be undone.');">
                                        <i class="fa fa-trash me-2"></i>Confirm Delete
                                    </button>
                                    <a href="user?action=list&section=User_List" class="btn btn-secondary">
                                        <i class="fa fa-times me-2"></i>Cancel
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
