package com.mizore.dao.impl;

import com.mizore.utils.DbUtilsConfig;

import com.mizore.dao.UserDAO;
import com.mizore.entity.User;
import com.mizore.utils.DruidUtils;
import com.mizore.utils.DbUtilsConfig;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

public class UserDAOImpl implements UserDAO {

    private QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());

    @Override
    public User getUser(String username) {
        String sql = "SELECT * FROM user WHERE username = ?";
        try {
            return queryRunner.query(sql, DbUtilsConfig.newBeanHandler(User.class), username);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public User getById(Long id) {
        String sql = "SELECT * FROM user WHERE id = ?";
        try {
            return queryRunner.query(sql, DbUtilsConfig.newBeanHandler(User.class), id);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<User> list() {
        String sql = "SELECT * FROM user ORDER BY id";
        try {
            List<User> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(User.class));
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<User> page(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM user ORDER BY id LIMIT ? OFFSET ?";
        try {
            List<User> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(User.class), pageSize, offset);
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public long count() {
        String sql = "SELECT COUNT(*) FROM user";
        try {
            Number num = queryRunner.query(sql, new ScalarHandler<>());
            return num != null ? num.longValue() : 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void register(User user) {
        String sql = "INSERT INTO user (username, password, phone, email, sex, avatar, status, create_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            queryRunner.update(sql,
                    user.getUsername(),
                    user.getPassword(),
                    user.getPhone(),
                    user.getEmail(),
                    user.getSex(),
                    user.getAvatar(),
                    user.getStatus() != null ? user.getStatus() : 1,
                    user.getCreateTime());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean update(User user) {
        String sql = "UPDATE user SET phone = ?, email = ?, sex = ?, avatar = ?, status = ? WHERE id = ?";
        try {
            int rows = queryRunner.update(sql,
                    user.getPhone(), user.getEmail(), user.getSex(), user.getAvatar(), user.getStatus(), user.getId());
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean updatePassword(Long id, String password) {
        String sql = "UPDATE user SET password = ? WHERE id = ?";
        try {
            int rows = queryRunner.update(sql, password, id);
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean delete(Long id) {
        String sql = "DELETE FROM user WHERE id = ?";
        try {
            int rows = queryRunner.update(sql, id);
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

