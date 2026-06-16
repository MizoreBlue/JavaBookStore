package com.mizore.servlet.admin;

import com.mizore.entity.Employee;
import com.mizore.entity.User;
import com.mizore.service.UserService;
import com.mizore.utils.PageResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/backend/user")
public class AdminUserServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Employee employee = (Employee) request.getSession().getAttribute("employee");
        if (employee == null) {
            response.sendRedirect(request.getContextPath() + "/backend/login");
            return;
        }
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            showEditForm(request, response);
            return;
        } else if ("save".equals(action)) {
            handleSave(request, response);
            return;
        } else if ("changePassword".equals(action)) {
            handleChangePassword(request, response);
            return;
        } else if ("toggleStatus".equals(action)) {
            handleToggleStatus(request, response);
            return;
        } else if ("delete".equals(action)) {
            Long id = parseLong(request.getParameter("id"));
            if (id != null) {
                userService.delete(id);
            }
            response.sendRedirect(request.getContextPath() + "/backend/user");
            return;
        }
        int page = parseInt(request.getParameter("page"), 1);
        int pageSize = parseInt(request.getParameter("pageSize"), 10);
        PageResult<User> pageResult = userService.page(page, pageSize);
        request.setAttribute("pageResult", pageResult);
        request.getRequestDispatcher("/WEB-INF/views/admin/user_list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = parseLong(request.getParameter("id"));
        if (id != null) {
            User user = userService.getById(id);
            request.setAttribute("user", user);
        }
        request.getRequestDispatcher("/WEB-INF/views/admin/user_edit.jsp").forward(request, response);
    }

    private void handleSave(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = parseLong(request.getParameter("id"));
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String sex = request.getParameter("sex");
        String avatar = request.getParameter("avatar");
        String statusStr = request.getParameter("status");

        User user = User.builder()
                .id(id)
                .phone(phone)
                .email(email)
                .sex(sex)
                .avatar(avatar)
                .status("0".equals(statusStr) ? 0 : 1)
                .build();
        userService.update(user);
        response.sendRedirect(request.getContextPath() + "/backend/user");
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = parseLong(request.getParameter("id"));
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (id == null) {
            request.setAttribute("error", "用户ID不能为空");
            request.getRequestDispatcher("/WEB-INF/views/admin/user_edit.jsp").forward(request, response);
            return;
        }
        if (newPassword == null || newPassword.isEmpty()) {
            request.setAttribute("error", "新密码不能为空");
            request.setAttribute("user", userService.getById(id));
            request.getRequestDispatcher("/WEB-INF/views/admin/user_edit.jsp").forward(request, response);
            return;
        }
        if (newPassword.length() < 6 || newPassword.length() > 20) {
            request.setAttribute("error", "密码长度需在6-20个字符之间");
            request.setAttribute("user", userService.getById(id));
            request.getRequestDispatcher("/WEB-INF/views/admin/user_edit.jsp").forward(request, response);
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "两次输入的密码不一致");
            request.setAttribute("user", userService.getById(id));
            request.getRequestDispatcher("/WEB-INF/views/admin/user_edit.jsp").forward(request, response);
            return;
        }

        userService.updatePassword(id, newPassword);
        response.sendRedirect(request.getContextPath() + "/backend/user");
    }

    private void handleToggleStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = parseLong(request.getParameter("id"));
        if (id != null) {
            User user = userService.getById(id);
            if (user != null) {
                int newStatus = (user.getStatus() != null && user.getStatus() == 1) ? 0 : 1;
                user.setStatus(newStatus);
                userService.update(user);
            }
        }
        response.sendRedirect(request.getContextPath() + "/backend/user");
    }

    private int parseInt(String s, int defaultValue) {
        try {
            return s == null ? defaultValue : Integer.parseInt(s);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private Long parseLong(String s) {
        try {
            return s == null ? null : Long.parseLong(s);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
