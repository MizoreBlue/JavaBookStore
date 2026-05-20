package com.mizore.dao.impl;

import com.mizore.dao.OrderDetailDAO;
import com.mizore.dao.SalesDAO;
import com.mizore.entity.OrderDetail;

import java.util.List;

public class OrderDetailDAOImpl implements OrderDetailDAO {


    /**
     * 根据订单Id获取详细信息
     * @param orderIds
     * @return
     */
    public List<OrderDetail> getByOrderIds(List<String> orderIds) {
        return List.of();
    }
}