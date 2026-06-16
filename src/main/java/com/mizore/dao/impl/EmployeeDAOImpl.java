package com.mizore.dao.impl;

import com.mizore.utils.DbUtilsConfig;

import com.mizore.dao.EmployeeDAO;
import com.mizore.entity.Employee;
import com.mizore.utils.DruidUtils;
import com.mizore.utils.DbUtilsConfig;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

public class EmployeeDAOImpl implements EmployeeDAO {

    private QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());

    @Override
    public Employee getByUsername(String username) {
        String sql = "SELECT * FROM employee WHERE username = ?";
        try {
            return queryRunner.query(sql, DbUtilsConfig.newBeanHandler(Employee.class), username);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Employee getById(Long id) {
        String sql = "SELECT * FROM employee WHERE id = ?";
        try {
            return queryRunner.query(sql, DbUtilsConfig.newBeanHandler(Employee.class), id);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Employee> page(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM employee ORDER BY id LIMIT ? OFFSET ?";
        try {
            List<Employee> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(Employee.class), pageSize, offset);
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public long count() {
        String sql = "SELECT COUNT(*) FROM employee";
        try {
            Number num = queryRunner.query(sql, new ScalarHandler<>());
            return num != null ? num.longValue() : 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

