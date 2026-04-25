package com.mizore.dao.impl;

import com.mizore.dao.BookDAO;
import com.mizore.entity.Book;
import com.mizore.utils.DruidUtils;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BookDAOImpl implements BookDAO {

    // 查询所有书籍
    public List<Book> findAll() {
        List<Book> bookList = new ArrayList<>();
        String sql = "SELECT * FROM book";

//        从链接池获取链接
        try (Connection conn = DruidUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
              ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Book book = new Book();

//               设置返回的数据
                book.setId(rs.getLong("id"));
                book.setName(rs.getString("name")); // 对应数据库字段
                book.setAuthor(rs.getString("author"));
                book.setPrice(new java.math.BigDecimal(rs.getString("price")));
                book.setDescription(rs.getString("description"));
                book.setCategory(rs.getString("category"));
                book.setStock(rs.getInt("stock"));
                book.setImage(rs.getString("image"));


                bookList.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookList;
    }


    /**
     * 插入一条数据
     * @param book
     * @return
     */
    public boolean insert(Book book) {

//        准备sql语句
        String sql = "INSERT INTO book (name, author, price, description, category, image, stock,create_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";


//        获得 JDBC链接
        try(Connection connection = DruidUtils.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql))
        {
            preparedStatement.setString(1, book.getName());
            preparedStatement.setString(2, book.getAuthor());
            preparedStatement.setBigDecimal(3, book.getPrice());
            preparedStatement.setString(4, book.getDescription());
            preparedStatement.setString(5, book.getCategory());
            preparedStatement.setString(6, book.getImage());
            preparedStatement.setInt(7, book.getStock());
            preparedStatement.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now()));

//            执行sql
            int rows = preparedStatement.executeUpdate();

            if (rows > 0) {
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // 在实际开发中，这里可能需要根据异常类型（如主键冲突、字段过长）给用户不同的提示
        }

        return false;
    }
}