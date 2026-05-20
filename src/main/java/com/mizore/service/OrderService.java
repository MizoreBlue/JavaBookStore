package com.mizore.service;

import com.mizore.entity.Book;
import com.mizore.entity.Orders;
import com.mizore.entity.vo.OrderVo;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

public interface OrderService {


    /**
     * 查询所有订单列表
     * @return 订单集合
     */
    List<OrderVo> getAllOrders();
}
