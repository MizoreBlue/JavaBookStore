package com.mizore.servlet.admin;

import com.mizore.entity.Employee;
import com.mizore.service.EmployeeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/backend/login")
public class AdminLoginServlet extends HttpServlet {

    private EmployeeService employeeService = new EmployeeService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Employee employee = employeeService.login(username, password);
        if (employee != null) {
            request.getSession().setAttribute("employee", employee);
            response.sendRedirect(request.getContextPath() + "/backend/home");
        } else {
            request.setAttribute("message", "用户名或密码错误");
            request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp").forward(request, response);
        }
    }
}
