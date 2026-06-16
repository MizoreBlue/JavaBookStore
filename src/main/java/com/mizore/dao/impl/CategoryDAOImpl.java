package com.mizore.dao.impl;

import com.mizore.utils.DbUtilsConfig;

import com.mizore.dao.CategoryDAO;
import com.mizore.entity.Category;
import com.mizore.utils.DruidUtils;
import com.mizore.utils.DbUtilsConfig;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {

    private QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());

    @Override
    public Category findById(Long id) {
        String sql = "SELECT * FROM category WHERE id = ?";
        try {
            return queryRunner.query(sql, DbUtilsConfig.newBeanHandler(Category.class), id);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Category> findAll() {
        String sql = "SELECT * FROM category ORDER BY sort";
        try {
            List<Category> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(Category.class));
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Category> page(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM category ORDER BY id LIMIT ? OFFSET ?";
        try {
            List<Category> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(Category.class), pageSize, offset);
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public long count() {
        String sql = "SELECT COUNT(*) FROM category";
        try {
            Number num = queryRunner.query(sql, new ScalarHandler<>());
            return num != null ? num.longValue() : 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Long insert(Category category) {
        String sql = "INSERT INTO category (type, name, sort, status, create_time, update_time) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            queryRunner.update(sql,
                    category.getType(), category.getName(), category.getSort(),
                    category.getStatus(), category.getCreateTime(), category.getUpdateTime());
            return 1L;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean update(Category category) {
        String sql = "UPDATE category SET name = ?, type = ?, sort = ?, status = ?, update_time = ? WHERE id = ?";
        try {
            int rows = queryRunner.update(sql,
                    category.getName(), category.getType(), category.getSort(), category.getStatus(),
                    category.getUpdateTime(), category.getId());
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean delete(Long id) {
        String sql = "DELETE FROM category WHERE id = ?";
        try {
            int rows = queryRunner.update(sql, id);
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

