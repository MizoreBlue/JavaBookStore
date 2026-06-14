package com.mizore.dao;

import com.mizore.entity.OrderDetail;

import java.util.List;

public interface OrderDetailDAO {
    List<OrderDetail> getByOrderId(Long orderId);
    List<OrderDetail> getByOrderIds(List<Long> orderIds);
    void insert(OrderDetail detail);
    void deleteByOrderId(Long orderId);
}
