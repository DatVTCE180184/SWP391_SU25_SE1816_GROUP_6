<%@ page import="dao.UserDao" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>

<%
    UserDao dao = new UserDao();
    List<User> users = dao.getAllUser();
%>

<h2>User Management</h2>
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
        </tr>
    </thead>
    <tbody>
        <%
            int stt = 1;
            for (User u : users) {
                if (u.getRole_ID() != 1) {
        %>
        <tr>
            <td><%= stt++ %></td> <!-- T?ng STT -->
            <td><%= u.getUsername() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getPhone() %></td>
            <td><%= u.getAddress() %></td>
            <td><%= u.getGender() == 1 ? "Male" : u.getGender() == 2 ? "Female" : "Other" %></td>
            <td><%= u.getRole_ID() == 2 ? "Staff" : "Customer" %></td>
        </tr>
        <%
                }
            }
        %>
    </tbody>
</table>
