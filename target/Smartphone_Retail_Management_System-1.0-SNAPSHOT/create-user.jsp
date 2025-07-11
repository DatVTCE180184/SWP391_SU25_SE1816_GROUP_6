<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create New User</title>
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow">
                        <div class="card-header bg-success text-white">
                            <h3 class="mb-0"><i class="fa fa-user-plus me-2"></i>Create New User</h3>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty errorMsg}">
                                <div class="alert alert-danger" role="alert">
                                    <i class="fa fa-exclamation-triangle me-2"></i>${errorMsg}
                                </div>
                            </c:if>
                            
                            <form action="user?action=create" method="post" id="createUserForm">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="username" class="form-label">Username: <span class="text-danger">*</span></label>
                                        <input type="text" id="username" name="username" class="form-control" 
                                               value="${param.username}" required 
                                               pattern="[a-zA-Z0-9_]{3,20}" 
                                               title="Username must be 3-20 characters, letters, numbers, and underscore only" />
                                        <div class="form-text">3-20 characters, letters, numbers, and underscore only</div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="password" class="form-label">Password: <span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <input type="password" id="password" name="password" class="form-control" 
                                                   required minlength="6" 
                                                   pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{6,}$"
                                                   title="Password must be at least 6 characters with uppercase, lowercase, and number" />
                                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                                <i class="fa fa-eye"></i>
                                            </button>
                                        </div>
                                        <div class="form-text">Minimum 6 characters with uppercase, lowercase, and number</div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="confirmPassword" class="form-label">Confirm Password: <span class="text-danger">*</span></label>
                                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" 
                                               required />
                                        <div class="form-text">Re-enter your password</div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="fullname" class="form-label">Full Name: <span class="text-danger">*</span></label>
                                        <input type="text" id="fullname" name="fullname" class="form-control" 
                                               value="${param.fullname}" required 
                                               pattern="[a-zA-Z\s]{2,50}" 
                                               title="Full name must be 2-50 characters, letters and spaces only" />
                                        <div class="form-text">2-50 characters, letters and spaces only</div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="email" class="form-label">Email: <span class="text-danger">*</span></label>
                                        <input type="email" id="email" name="email" class="form-control" 
                                               value="${param.email}" required />
                                        <div class="form-text">Enter a valid email address</div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="phone" class="form-label">Phone: <span class="text-danger">*</span></label>
                                        <input type="tel" id="phone" name="phone" class="form-control" 
                                               value="${param.phone}" required 
                                               pattern="[0-9+\-\s\(\)]{10,15}" 
                                               title="Phone number must be 10-15 digits" />
                                        <div class="form-text">10-15 digits, can include +, -, spaces, parentheses</div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="address" class="form-label">Address: <span class="text-danger">*</span></label>
                                    <textarea id="address" name="address" class="form-control" rows="3" 
                                              required maxlength="200">${param.address}</textarea>
                                    <div class="form-text">Maximum 200 characters</div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="role" class="form-label">Role: <span class="text-danger">*</span></label>
                                        <select id="role" name="role" class="form-select" required>
                                            <option value="">Select Role</option>
                                            <option value="3" <c:if test="${param.role == '3'}">selected</c:if>>Customer</option>
                                            <option value="2" <c:if test="${param.role == '2'}">selected</c:if>>Staff</option>
                                            <option value="1" <c:if test="${param.role == '1'}">selected</c:if>>Admin</option>
                                        </select>
                                        <div class="form-text">Choose the user's role in the system</div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="gender" class="form-label">Gender: <span class="text-danger">*</span></label>
                                        <select id="gender" name="gender" class="form-select" required>
                                            <option value="">Select Gender</option>
                                            <option value="1" <c:if test="${param.gender == '1'}">selected</c:if>>Male</option>
                                            <option value="2" <c:if test="${param.gender == '2'}">selected</c:if>>Female</option>
                                        </select>
                                        <div class="form-text">Select the user's gender</div>
                                    </div>
                                </div>

                                <div class="d-flex gap-2 mt-4">
                                    <button type="submit" class="btn btn-success">
                                        <i class="fa fa-user-plus me-2"></i>Create User
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

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        
        <!-- Custom JavaScript for form validation -->
        <script>
            // Password visibility toggle
            document.getElementById('togglePassword').addEventListener('click', function() {
                const password = document.getElementById('password');
                const icon = this.querySelector('i');
                
                if (password.type === 'password') {
                    password.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    password.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            });

            // Password confirmation validation
            document.getElementById('createUserForm').addEventListener('submit', function(e) {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                
                if (password !== confirmPassword) {
                    e.preventDefault();
                    alert('Passwords do not match!');
                    document.getElementById('confirmPassword').focus();
                    return false;
                }
            });

            // Real-time password confirmation check
            document.getElementById('confirmPassword').addEventListener('input', function() {
                const password = document.getElementById('password').value;
                const confirmPassword = this.value;
                
                if (confirmPassword && password !== confirmPassword) {
                    this.setCustomValidity('Passwords do not match');
                } else {
                    this.setCustomValidity('');
                }
            });
        </script>
    </body>
</html>
