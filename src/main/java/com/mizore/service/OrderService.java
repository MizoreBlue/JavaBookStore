package com.mizore.service;

import com.mizore.dao.BookDAO;
import com.mizore.dao.OrderDAO;
import com.mizore.dao.OrderDetailDAO;
import com.mizore.dao.UserDAO;
import com.mizore.entity.Book;
import com.mizore.entity.Cart;
import com.mizore.entity.OrderDetail;
import com.mizore.entity.Orders;
import com.mizore.entity.User;
import com.mizore.entity.vo.OrderVo;
import com.mizore.utils.PageResult;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class OrderService {

    private OrderDAO orderDAO = ServiceFactory.getOrderDAO();
    private OrderDetailDAO orderDetailDAO = ServiceFactory.getOrderDetailDAO();
    private BookDAO bookDAO = ServiceFactory.getBookDAO();
    private UserDAO userDAO = ServiceFactory.getUserDAO();

    public PageResult<Orders> page(int page, int pageSize) {
        if (page < 1) page = 1;
        return PageResult.of(orderDAO.page(page, pageSize), orderDAO.count(), page, pageSize);
    }

    public List<OrderVo> pageWithDetails(int page, int pageSize) {
        PageResult<Orders> orderPage = page(page, pageSize);
        return buildOrderVoList(orderPage.getRecords());
    }

    public List<OrderVo> getAllOrderVos() {
        List<Orders> orders = orderDAO.getAllOrders();
        return buildOrderVoList(orders);
    }

    public List<OrderVo> getByUserId(Long userId) {
        List<Orders> orders = orderDAO.getOrdersByUserId(userId);
        return buildOrderVoList(orders);
    }

    private List<OrderVo> buildOrderVoList(List<Orders> orderList) {
        List<OrderVo> result = new ArrayList<>();
        if (orderList == null || orderList.isEmpty()) {
            return result;
        }
        List<Long> orderIds = orderList.stream().map(Orders::getId).collect(Collectors.toList());
        List<OrderDetail> allDetails = orderDetailDAO.getByOrderIds(orderIds);
        Map<Long, List<OrderDetail>> detailMap = allDetails.stream()
                .collect(Collectors.groupingBy(OrderDetail::getOrderId));
        for (Orders order : orderList) {
            OrderVo vo = new OrderVo();
            vo.setOrders(order);
            vo.setOrderDetailList(detailMap.getOrDefault(order.getId(), new ArrayList<>()));
            if (order.getUserId() != null) {
                vo.setUser(userDAO.getById(order.getUserId()));
            }
            result.add(vo);
        }
        return result;
    }

    public boolean placeOrder(Long userId, String address, String receiverName, String receiverPhone, List<Cart> cartList) {
        if (cartList == null || cartList.isEmpty()) {
            return false;
        }
        for (Cart cart : cartList) {
            Book book = bookDAO.findById(cart.getBookId());
            if (book == null || book.getStock() < cart.getQuantity()) {
                return false;
            }
        }
        BigDecimal total = BigDecimal.ZERO;
        for (Cart cart : cartList) {
            total = total.add(cart.getAmount());
        }
        Orders order = new Orders();
        order.setUserId(userId);
        order.setAddress(address);
        order.setReceiverName(receiverName);
        order.setReceiverPhone(receiverPhone);
        order.setTotalAmount(total);
        order.setStatus(1);
        order.setCreateTime(LocalDateTime.now());
        Long orderId = orderDAO.insert(order);
        for (Cart cart : cartList) {
            OrderDetail detail = new OrderDetail();
            detail.setOrderId(orderId);
            detail.setBookId(cart.getBookId());
            detail.setBookName(cart.getName());
            detail.setImage(cart.getImage());
            detail.setNumber(cart.getQuantity());
            detail.setAmount(cart.getAmount());
            orderDetailDAO.insert(detail);
            bookDAO.updateStock(cart.getBookId(), cart.getQuantity());
        }
        return true;
    }

    public boolean updateStatus(Long orderId, Integer status) {
        return orderDAO.updateStatus(orderId, status);
    }

    public boolean delete(Long orderId) {
        orderDetailDAO.deleteByOrderId(orderId);
        return orderDAO.delete(orderId);
    }

    public long count() {
        return orderDAO.count();
    }
}
