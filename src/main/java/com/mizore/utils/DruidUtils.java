package com.mizore.utils;

import com.alibaba.druid.pool.DruidDataSourceFactory;
import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 * 基于 Druid 连接池的数据库工具类
 */
public class DruidUtils {
    private static DataSource dataSource;

    // 1. 静态代码块：初始化连接池
    static {
        try {
            // 1. 加载配置文件
            InputStream is = DruidUtils.class.getClassLoader().getResourceAsStream("db.properties");
            Properties pros = new Properties();
            pros.load(is);

            // 2. 使用 Druid 的工厂类创建数据源（连接池）
            dataSource = DruidDataSourceFactory.createDataSource(pros);

            System.out.println("Druid 连接池初始化成功！");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Druid 连接池初始化失败", e);
        }
    }

    // 2. 获取连接
    public static Connection getConnection() throws SQLException {
        // 从连接池中获取一个连接
        return dataSource.getConnection();
    }

    // 3. 释放资源
    // 注意：这里的 close() 实际上是将连接归还给连接池，而不是物理关闭
    public static void close(Connection conn, Statement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
        } catch (SQLException e) { e.printStackTrace(); }

        try {
            if (ps != null) ps.close();
        } catch (SQLException e) { e.printStackTrace(); }

        try {
            if (conn != null) conn.close();
        } catch (SQLException e) { e.printStackTrace(); }
    }

}