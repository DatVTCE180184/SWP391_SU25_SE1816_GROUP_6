<%-- Document : update-user Created on : Jul 11, 2025, 8:13:00 AM Author : ADMIN --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update User</title>
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
              rel="stylesheet" />
    </head>

    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white">
                            <h3 class="mb-0"><i class="fa fa-user-edit me-2"></i>Update User Information</h3>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty errorMsg}">
                                <div class="alert alert-danger" role="alert">
                                    <i class="fa fa-exclamation-triangle me-2"></i>${errorMsg}
                                </div>
                            </c:if>
                            <form action="user?action=update" method="post">
                                <input type="hidden" name="userId" value="${user.ID}" />

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="username" class="form-label">Username:</label>
                                        <input type="text" id="username" name="username" class="form-control"
                                               value="${user.username}" required />
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="fullname" class="form-label">Full Name:</label>
                                        <input type="text" id="fullname" name="fullname" class="form-control"
                                               value="${user.fullname}" required />
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="email" class="form-label">Email:</label>
                                        <input type="email" id="email" name="email" class="form-control"
                                               value="${user.email}" required />
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="phone" class="form-label">Phone:</label>
                                        <input type="tel" id="phone" name="phone" class="form-control"
                                               value="${user.phone}" required />
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="address" class="form-label">Address:</label>
                                    <input type="text" id="address" name="address" class="form-control"
                                           value="${user.address}" required />
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="role" class="form-label">Role:</label>
                                        <div class="alert alert-info py-2 mb-2">
                                            <small><strong>Current Role:</strong>
                                                <c:choose>
                                                    <c:when test="${user.role_ID == 1}">Admin</c:when>
                                                    <c:when test="${user.role_ID == 2}">Staff</c:when>
                                                    <c:when test="${user.role_ID == 3}">Customer</c:when>
                                                    <c:otherwise>Unknown</c:otherwise>
                                                </c:choose>
                                            </small>
                                        </div>
                                        <select id="role" name="role" class="form-select">
                                            <option value="3" <c:if test="${user.role_ID == 3}">selected</c:if>
                                                    >Customer</option>
                                                <option value="2" <c:if test="${user.role_ID == 2}">selected</c:if>
                                                        >Staff</option>
                                                <option value="1" <c:if test="${user.role_ID == 1}">selected</c:if>
                                                        >Admin</option>
                                            </select>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label for="gender" class="form-label">Gender:</label>
                                            <div class="alert alert-info py-2 mb-2">
                                                <small><strong>Current Gender:</strong>
                                                <c:choose>
                                                    <c:when test="${user.gender == 1}">Male</c:when>
                                                    <c:when test="${user.gender == 2}">Female</c:when>
                                                    <c:otherwise>Unknown</c:otherwise>
                                                </c:choose>
                                            </small>
                                        </div>
                                        <select id="gender" name="gender" class="form-select">
                                            <option value="1" <c:if test="${user.gender == 1}">selected</c:if>
                                                    >Male</option>
                                                <option value="2" <c:if test="${user.gender == 2}">selected</c:if>
                                                    >Female</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="d-flex gap-2 mt-4">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa fa-save me-2"></i>Update User
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
    </body>

</html>