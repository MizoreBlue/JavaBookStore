package com.mizore.servlet;

import com.mizore.entity.User;
import com.mizore.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("username") != null) {
                handleLogin(request, response);
            } else {
                request.getRequestDispatcher("/WEB-INF/views/front/login.jsp").forward(request, response);
            }
        } else if ("doLogin".equals(action)) {
            handleLogin(request, response);
        } else if ("register".equals(action)) {
            if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("username") != null) {
                handleRegister(request, response);
            } else {
                request.getRequestDispatcher("/WEB-INF/views/front/register.jsp").forward(request, response);
            }
        } else if ("doRegister".equals(action)) {
            handleRegister(request, response);
        } else if ("profile".equals(action)) {
            showProfile(request, response);
        } else if ("update".equals(action)) {
            handleUpdate(request, response);
        } else if ("logout".equals(action)) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            request.getRequestDispatcher("/WEB-INF/views/front/login.jsp").forward(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = userService.login(username, password);
        if (user != null) {
            if (user.getStatus() != null && user.getStatus() == 0) {
                request.setAttribute("message", "账号已被禁用，请联系管理员");
                request.getRequestDispatcher("/WEB-INF/views/front/login.jsp").forward(request, response);
                return;
            }
            request.getSession().setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            request.setAttribute("message", "用户名或密码错误");
            request.getRequestDispatcher("/WEB-INF/views/front/login.jsp").forward(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String sex = request.getParameter("sex");

        // 输入验证
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("message", "用户名不能为空");
            request.getRequestDispatcher("/WEB-INF/views/front/register.jsp").forward(request, response);
            return;
        }
        if (username.trim().length() < 3 || username.trim().length() > 20) {
            request.setAttribute("message", "用户名长度需在3-20个字符之间");
            request.getRequestDispatcher("/WEB-INF/views/front/register.jsp").forward(request, response);
            return;
        }
        if (password == null || password.isEmpty()) {
            request.setAttribute("message", "密码不能为空");
            request.getRequestDispatcher("/WEB-INF/views/front/register.jsp").forward(request, response);
            return;
        }
        if (password.length() < 6 || password.length() > 20) {
            request.setAttribute("message", "密码长度需在6-20个字符之间");
            request.getRequestDispatcher("/WEB-INF/views/front/register.jsp").forward(request, response);
            return;
        }
        if (!password.equals(confirmPassword)) {
            request.setAttribute("message", "两次输入的密码不一致");
            request.getRequestDispatcher("/WEB-INF/views/front/register.jsp").forward(request, response);
            return;
        }
        if (email != null && !email.isEmpty() && !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            request.setAttribute("message", "邮箱格式不正确");
            request.getRequestDispatcher("/WEB-INF/views/front/register.jsp").forward(request, response);
            return;
        }
        if (phone != null && !phone.isEmpty() && !phone.matches("^1[3-9]\\d{9}$")) {
            request.setAttribute("message", "手机号格式不正确");
            request.getRequestDispatcher("/WEB-INF/views/front/register.jsp").forward(request, response);
            return;
        }

        User user = User.builder()
                .username(username.trim())
                .password(password)
                .email(email != null ? email.trim() : null)
                .phone(phone != null ? phone.trim() : null)
                .sex(sex)
                .build();
        boolean success = userService.register(user);
        if (success) {
            request.setAttribute("message", "注册成功，请登录");
            request.getRequestDispatcher("/WEB-INF/views/front/login.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "用户名已存在，请更换");
            request.getRequestDispatcher("/WEB-INF/views/front/register.jsp").forward(request, response);
        }
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User currentUser = (User) request.getSession().getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/user?action=login");
            return;
        }
        User user = userService.getById(currentUser.getId());
        request.setAttribute("userProfile", user);
        request.getRequestDispatcher("/WEB-INF/views/front/profile.jsp").forward(request, response);
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User currentUser = (User) request.getSession().getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/user?action=login");
            return;
        }
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String sex = request.getParameter("sex");
        String avatar = request.getParameter("avatar");
        User user = User.builder()
                .id(currentUser.getId())
                .email(email)
                .phone(phone)
                .sex(sex)
                .avatar(avatar)
                .build();
        userService.update(user);
        User updatedUser = userService.getById(currentUser.getId());
        request.getSession().setAttribute("user", updatedUser);
        response.sendRedirect(request.getContextPath() + "/user?action=profile");
    }
}
