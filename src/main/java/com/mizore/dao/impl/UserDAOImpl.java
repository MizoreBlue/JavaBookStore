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

            // 处理时间类型：java.time.LocalDateTime 转 java.sql.Timestamp
            if (user.getCreateTime() != null) {
                pstmt.setTimestamp(7, Timestamp.valueOf(user.getCreateTime()));
            } else {
                pstmt.setTimestamp(7, Timestamp.valueOf(LocalDateTime.now())); // 如果没传时间，默认当前时间
            }

            // 4. 执行 SQL
            // executeUpdate 返回的是受影响的行数（int）
            int rows = pstmt.executeUpdate();

            // 5. 判断结果
            if (rows > 0) {
                System.out.println("注册成功！");

                // 【进阶技巧】获取数据库生成的自增主键 ID
                // 如果 insert 成功，通常我们需要知道这个用户的 ID 是多少
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    long generatedId = generatedKeys.getLong(1);
                    user.setId(generatedId); // 将生成的 ID 回填到 User 对象中
                    System.out.println("生成的用户ID为: " + generatedId);
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
     * @param username
     * @return
     */
    public User getUser(String username) {
        String sql = "SELECT * FROM user WHERE username = ?";
        User user = new User();

        try(Connection conn = DruidUtils.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){

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
            return  user;
        } catch (SQLException e) {
//            打印异常堆栈
            e.printStackTrace();
        }
        return user;
    }
}