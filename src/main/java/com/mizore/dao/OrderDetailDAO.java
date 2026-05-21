package com.mizore.dao;

import com.mizore.entity.OrderDetail;

import java.util.List;

public interface OrderDetailDAO {


    /**
     * 根据订单Id 获取订单详细信息
     * @param orderIds
     * @return
     */
    List<OrderDetail> getByOrderIds(List<Long> orderIds);
}
