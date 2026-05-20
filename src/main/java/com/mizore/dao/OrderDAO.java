package com.mizore.dao;

import com.mizore.entity.Book;
import com.mizore.entity.Orders;

import java.util.List;

public interface OrderDAO {


    /**
     * 获取所有订单
     * @return
     */
    List<Orders> getAllOrders();
}
