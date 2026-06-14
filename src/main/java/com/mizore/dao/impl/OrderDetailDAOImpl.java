package com.mizore.dao.impl;

import com.mizore.utils.DbUtilsConfig;

import com.mizore.dao.OrderDetailDAO;
import com.mizore.entity.OrderDetail;
import com.mizore.utils.DruidUtils;
import com.mizore.utils.DbUtilsConfig;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

public class OrderDetailDAOImpl implements OrderDetailDAO {

    private QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());

    @Override
    public List<OrderDetail> getByOrderId(Long orderId) {
        String sql = "SELECT * FROM order_detail WHERE order_id = ?";
        try {
            List<OrderDetail> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(OrderDetail.class), orderId);
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<OrderDetail> getByOrderIds(List<Long> orderIds) {
        if (orderIds == null || orderIds.isEmpty()) {
            return Collections.emptyList();
        }
        StringBuilder sb = new StringBuilder("SELECT * FROM order_detail WHERE order_id IN (");
        for (int i = 0; i < orderIds.size(); i++) {
            sb.append("?");
            if (i < orderIds.size() - 1) sb.append(",");
        }
        sb.append(")");
        Object[] params = orderIds.toArray();
        try {
            List<OrderDetail> list = queryRunner.query(sb.toString(), DbUtilsConfig.newBeanListHandler(OrderDetail.class), params);
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void insert(OrderDetail detail) {
        String sql = "INSERT INTO order_detail (order_id, book_id, number, amount, image, book_name) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            queryRunner.update(sql,
                    detail.getOrderId(), detail.getBookId(), detail.getNumber(),
                    detail.getAmount(), detail.getImage(), detail.getBookName());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteByOrderId(Long orderId) {
        String sql = "DELETE FROM order_detail WHERE order_id = ?";
        try {
            queryRunner.update(sql, orderId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

