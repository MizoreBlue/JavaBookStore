package com.mizore.servlet.admin;


import com.mizore.entity.Orders;
import com.mizore.entity.vo.OrderVo;
import com.mizore.service.OrderService;
import com.mizore.service.impl.OrderServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * 订单管理
 *
 * @author MizoreBlue
 */

@WebServlet(urlPatterns = "/backend/order/*")
public class OrderServlet extends HttpServlet {

    private OrderService orderService = new OrderServiceImpl();



    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String uri = request.getRequestURI();

//        查询订单列表
        if (uri.contains("/list")) {
            List<OrderVo> orderVOList =  orderService.getAllOrders();
            request.setAttribute("orderVOList", orderVOList);
            request.getRequestDispatcher("/WEB-INF/views/admin/order_list.jsp").forward(request, response);
        }



    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

}
