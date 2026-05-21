package com.mizore.dao.impl;

import com.mizore.dao.OrderDetailDAO;
import com.mizore.entity.OrderDetail;
import com.mizore.utils.DruidUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAOImpl implements OrderDetailDAO {


    /**
     * 根据订单Id获取详细信息
     *
     * @param orderIds
     * @return
     */
    public List<OrderDetail> getByOrderIds(List<Long> orderIds) {

        List<OrderDetail> orderDetails = new ArrayList<>();


//        如果列表为空，直接返回空列表，避免sql语法错误
        if (orderIds == null || orderIds.isEmpty()) {
            return orderDetails;
        }

//        动态生成占位符(?,?,?) 将List转换为分隔的问号字符串

        String placeholders = String.join(",", orderIds.stream().map(id -> "?").toList());


        String sql = "select * from order_detail where order_id in ("+placeholders+")";

        try (
                Connection connection = DruidUtils.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(sql)
        ) {

//            循环设置参数
            for (int i = 0; i < orderIds.size(); i++) {
                preparedStatement.setObject(i+1, orderIds.get(i));
            }

//            执行 sql
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrderId(resultSet.getLong("order_id"));
                orderDetail.setId(resultSet.getLong("id"));
                orderDetail.setAmount(resultSet.getBigDecimal("amount"));
                orderDetail.setImage(resultSet.getString("image"));
                orderDetail.setNumber(resultSet.getInt("number"));
                orderDetail.setBookId(resultSet.getLong("book_id"));
                orderDetail.setAmount(resultSet.getBigDecimal("amount"));
                orderDetails.add(orderDetail);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderDetails;
    }
}