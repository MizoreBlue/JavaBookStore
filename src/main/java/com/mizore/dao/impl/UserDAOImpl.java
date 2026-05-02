package com.mizore.dao.impl;

import com.mizore.dao.UserDAO;
import com.mizore.entity.User;
import com.mizore.utils.DruidUtils; // 假设你有这个工具类

import java.sql.*;
import java.time.LocalDateTime;

public class UserDAOImpl implements UserDAO {

    /**
     * 用户注册
     */
    public void register(User user) {
        // 1. 定义 SQL
        String sql = "INSERT INTO user (username, password, phone, email, sex, avatar, create_time) VALUES (?, ?, ?, ?, ?, ?, ?)";

        // 2. 使用 try-with-resources 自动管理资源
        // 这里的 conn 和 pstmt 会在代码块结束后自动关闭，无需手动写 finally
        try (Connection conn = DruidUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 3. 设置参数 (防 SQL 注入的核心步骤)
            // 索引从 1 开始，必须与 SQL 中的 ? 顺序一一对应
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getPhone());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getSex());
            pstmt.setString(6, user.getAvatar());
            pstmt.setTimestamp(7, Timestamp.valueOf(LocalDateTime.now()));

            // 4. 执行 SQL
            // executeUpdate 返回的是受影响的行数（int）
            int rows = pstmt.executeUpdate();


           if (rows > 0) {
               ResultSet generatedKeys = pstmt.getGeneratedKeys();
               if (generatedKeys.next()) {
                   user.setId(generatedKeys.getLong(1));
               }
           }
        } catch (SQLException e) {
            // 6. 异常处理
            e.printStackTrace();
            // 在实际开发中，这里可能需要根据异常类型（如主键冲突、字段过长）给用户不同的提示
        }

    }


    /**
     * 根据用户名称获取用户信息
     *
     * @param username
     * @return
     */
    public User getUser(String username) {
        String sql = "SELECT * FROM user WHERE username = ?";
        User user = new User();

        try (Connection conn = DruidUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

//            设置参数
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user.setId(rs.getLong("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
            }
            return user;
        } catch (SQLException e) {
//            打印异常堆栈
            e.printStackTrace();
        }
        return user;
    }
}