package com.mizore.servlet.admin;

import com.mizore.entity.Employee;
import com.mizore.entity.Orders;
import com.mizore.entity.vo.OrderVo;
import com.mizore.service.OrderService;
import com.mizore.utils.PageResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/backend/order")
public class AdminOrderServlet extends HttpServlet {

    private OrderService orderService = new OrderService();

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
        if ("status".equals(action)) {
            Long id = parseLong(request.getParameter("id"));
            Integer status = parseInt(request.getParameter("status"), 1);
            if (id != null) {
                orderService.updateStatus(id, status);
            }
            response.sendRedirect(request.getContextPath() + "/backend/order");
            return;
        } else if ("delete".equals(action)) {
            Long id = parseLong(request.getParameter("id"));
            if (id != null) {
                orderService.delete(id);
            }
            response.sendRedirect(request.getContextPath() + "/backend/order");
            return;
        }
        int page = parseInt(request.getParameter("page"), 1);
        int pageSize = parseInt(request.getParameter("pageSize"), 10);
        List<OrderVo> orderVos = orderService.pageWithDetails(page, pageSize);
        PageResult<Orders> pageResult = orderService.page(page, pageSize);
        request.setAttribute("orderVos", orderVos);
        request.setAttribute("pageResult", pageResult);
        request.getRequestDispatcher("/WEB-INF/views/admin/order_list.jsp").forward(request, response);
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
