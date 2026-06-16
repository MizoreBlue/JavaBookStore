package com.mizore.servlet.admin;

import com.mizore.entity.Employee;
import com.mizore.entity.dto.SalesRankDTO;
import com.mizore.entity.vo.OrderVo;
import com.mizore.entity.vo.SalesReportVO;
import com.mizore.service.OrderService;
import com.mizore.service.SalesService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/backend/home")
public class AdminHomeServlet extends HttpServlet {

    private SalesService salesService = new SalesService();
    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Employee employee = (Employee) request.getSession().getAttribute("employee");
        if (employee == null) {
            response.sendRedirect(request.getContextPath() + "/backend/login");
            return;
        }
        long totalUser = salesService.getTotalUserCount();
        long totalBook = salesService.getTotalBookCount();
        long todayOrder = salesService.getTodayOrderCount();
        long totalOrder = orderService.count();
        SalesReportVO report = salesService.getBusinessReport();
        List<SalesRankDTO> rank = salesService.getSalesRank();
        List<OrderVo> recentOrders = orderService.getAllOrderVos();
        if (recentOrders.size() > 10) {
            recentOrders = recentOrders.subList(0, 10);
        }
        request.setAttribute("totalUser", totalUser);
        request.setAttribute("totalBook", totalBook);
        request.setAttribute("todayOrder", todayOrder);
        request.setAttribute("totalOrder", totalOrder);
        request.setAttribute("report", report);
        request.setAttribute("rank", rank);
        request.setAttribute("recentOrders", recentOrders);
        request.getRequestDispatcher("/WEB-INF/views/admin/home.jsp").forward(request, response);
    }
}
