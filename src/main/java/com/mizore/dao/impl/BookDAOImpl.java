package com.mizore.dao.impl;

import com.mizore.dao.BookDAO;
import com.mizore.entity.Book;
import com.mizore.utils.DruidUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
}