package com.mizore.dao;

import com.mizore.entity.Orders;

import java.util.List;

public interface OrderDAO {
    Orders findById(Long id);
    List<Orders> getAllOrders();
    List<Orders> getOrdersByUserId(Long userId);
    List<Orders> page(int page, int pageSize);
    long count();
    long countByUserId(Long userId);
    Long insert(Orders order);
    boolean updateStatus(Long id, Integer status);
    boolean delete(Long id);
}
