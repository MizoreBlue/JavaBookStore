package com.mizore.utils;

import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class JDBCUtils {
    private static String url;
    private static String user;
    private static String password;
    private static String driver;

    // 1. 静态代码块：类加载时读取配置文件
    static {
        try {
            // 读取 resources 目录下的 db.properties
            InputStream is = JDBCUtils.class.getClassLoader().getResourceAsStream("db.properties");
            Properties pros = new Properties();
            pros.load(is);

            user = pros.getProperty("user");
            password = pros.getProperty("password");
            url = pros.getProperty("url");
            driver = pros.getProperty("driver");

            Class.forName(driver); // 注册驱动
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("JDBC 初始化失败", e);
        }
    }

    // 2. 获取连接
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }

    // 3. 释放资源 (如果使用 try-with-resources 语法，这一步可以省略，但写个工具类备用也好)
    public static void closeResource(Connection conn, Statement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
        } catch (SQLException e) { e.printStackTrace(); }
        try {
            if (ps != null) ps.close();
        } catch (SQLException e) { e.printStackTrace(); }
        try {
            if (conn != null) conn.close(); // 归还连接
        } catch (SQLException e) { e.printStackTrace(); }
    }
}