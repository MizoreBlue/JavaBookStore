package com.mizore.dao.impl;

import com.mizore.utils.DbUtilsConfig;

import com.mizore.dao.OrderDAO;
import com.mizore.entity.Orders;
import com.mizore.utils.DruidUtils;
import com.mizore.utils.DbUtilsConfig;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {

    private QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());

    @Override
    public Orders findById(Long id) {
        String sql = "SELECT * FROM orders WHERE id = ?";
        try {
            return queryRunner.query(sql, DbUtilsConfig.newBeanHandler(Orders.class), id);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Orders> getAllOrders() {
        String sql = "SELECT * FROM orders ORDER BY create_time DESC";
        try {
            List<Orders> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(Orders.class));
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Orders> getOrdersByUserId(Long userId) {
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY create_time DESC";
        try {
            List<Orders> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(Orders.class), userId);
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Orders> page(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM orders ORDER BY create_time DESC LIMIT ? OFFSET ?";
        try {
            List<Orders> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(Orders.class), pageSize, offset);
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public long count() {
        String sql = "SELECT COUNT(*) FROM orders";
        try {
            Number num = queryRunner.query(sql, new ScalarHandler<>());
            return num != null ? num.longValue() : 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public long countByUserId(Long userId) {
        String sql = "SELECT COUNT(*) FROM orders WHERE user_id = ?";
        try {
            Number num = queryRunner.query(sql, new ScalarHandler<>(), userId);
            return num != null ? num.longValue() : 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Long insert(Orders order) {
        String sql = "INSERT INTO orders (total_amount, address, receiver_name, receiver_phone, user_id, status, create_time) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            Number key = queryRunner.insert(sql, new ScalarHandler<>(),
                    order.getTotalAmount(), order.getAddress(), order.getReceiverName(),
                    order.getReceiverPhone(), order.getUserId(), order.getStatus(), order.getCreateTime());
            return key != null ? key.longValue() : 1L;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean updateStatus(Long id, Integer status) {
        String sql = "UPDATE orders SET status = ?, update_time = NOW() WHERE id = ?";
        try {
            int rows = queryRunner.update(sql, status, id);
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean delete(Long id) {
        String sql = "DELETE FROM orders WHERE id = ?";
        try {
            int rows = queryRunner.update(sql, id);
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

