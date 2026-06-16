package com.mizore.servlet;

import com.mizore.entity.Cart;
import com.mizore.entity.User;
import com.mizore.entity.vo.OrderVo;
import com.mizore.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String action = request.getParameter("action");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user?action=login");
            return;
        }
        if ("checkout".equals(action)) {
            List<Cart> cartList = (List<Cart>) request.getSession().getAttribute("cart");
            BigDecimal totalAmount = BigDecimal.ZERO;
            if (cartList != null) {
                for (Cart cart : cartList) {
                    totalAmount = totalAmount.add(cart.getAmount());
                }
            }
            request.setAttribute("cartList", cartList);
            request.setAttribute("totalAmount", totalAmount);
            request.getRequestDispatcher("/WEB-INF/views/front/checkout.jsp").forward(request, response);
            return;
        } else if ("place".equals(action)) {
            String address = request.getParameter("address");
            String receiverName = request.getParameter("receiverName");
            String receiverPhone = request.getParameter("receiverPhone");
            List<Cart> cartList = (List<Cart>) request.getSession().getAttribute("cart");
            boolean success = orderService.placeOrder(user.getId(), address, receiverName, receiverPhone, cartList);
            if (success) {
                request.getSession().removeAttribute("cart");
                response.sendRedirect(request.getContextPath() + "/order?action=list");
            } else {
                request.getSession().setAttribute("orderError", "库存不足，下单失败");
                response.sendRedirect(request.getContextPath() + "/order?action=checkout");
            }
            return;
        }
        List<OrderVo> orders = orderService.getByUserId(user.getId());
        request.setAttribute("orderVos", orders);
        request.getRequestDispatcher("/WEB-INF/views/front/order_list.jsp").forward(request, response);
    }
}
