package com.mizore.dao.impl;

import com.fasterxml.jackson.databind.util.BeanUtil;
import com.mizore.dao.OrderDAO;
import com.mizore.dao.OrderDetailDAO;
import com.mizore.entity.Orders;
import com.mizore.utils.DruidUtils;
import org.apache.commons.beanutils.BeanUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {

    /**
     * 获取所有订单
     * @return
     */
    public List<Orders> getAllOrders() {

        String sql = "SELECT * FROM orders";

        try(Connection collection = DruidUtils.getConnection();
            PreparedStatement preparedStatement = collection.prepareStatement(sql);
        ) {

            ResultSet resultSet = preparedStatement.executeQuery();

            List<Orders> list = new ArrayList<>();
            while (resultSet.next()) {
                Orders orders = new Orders();
                orders.setId(resultSet.getString("Id"));
                orders.setTotalAmount(resultSet.getBigDecimal("totalAmount"));
                orders.setAddress(resultSet.getString("address"));
                orders.setReceiverName(resultSet.getString("receiverName"));
                orders.setReceiverPhone(resultSet.getString("receiverPhone"));
                orders.setUserId(resultSet.getLong(resultSet.getString("userId")));
                orders.setStatus(resultSet.getInt("status"));

                list.add(orders);
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}