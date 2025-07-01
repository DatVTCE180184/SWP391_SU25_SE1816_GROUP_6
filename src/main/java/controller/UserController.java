package controller;

import dao.UserDao;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/user-management") // KHÔNG thêm /admin ở đây!
public class UserController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDao dao = new UserDao();
        List<User> users = dao.getAllUser();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/User.jsp").forward(request, response); // hoặc /admin/user.jsp nếu cần
    }
}
