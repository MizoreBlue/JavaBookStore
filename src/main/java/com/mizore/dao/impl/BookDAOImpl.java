package com.mizore.dao.impl;

import com.mizore.utils.DbUtilsConfig;

import com.mizore.dao.BookDAO;
import com.mizore.entity.Book;
import com.mizore.utils.DruidUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

public class BookDAOImpl implements BookDAO {

    private QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());

    @Override
    public Book findById(Long id) {
        String sql = "SELECT * FROM book WHERE id = ?";
        try {
            return queryRunner.query(sql, DbUtilsConfig.newBeanHandler(Book.class), id);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Book> findAll() {
        String sql = "SELECT * FROM book ORDER BY id DESC";
        try {
            List<Book> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(Book.class));
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Book> findByCategory(String category) {
        String sql = "SELECT * FROM book WHERE category = ? ORDER BY id DESC";
        try {
            List<Book> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(Book.class), category);
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Book> findByName(String name) {
        String sql = "SELECT * FROM book WHERE name LIKE ? ORDER BY id DESC";
        try {
            List<Book> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(Book.class), "%" + name + "%");
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Book> page(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM book ORDER BY id DESC LIMIT ? OFFSET ?";
        try {
            List<Book> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(Book.class), pageSize, offset);
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Book> pageByCategory(String category, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM book WHERE category = ? ORDER BY id DESC LIMIT ? OFFSET ?";
        try {
            List<Book> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(Book.class), category, pageSize, offset);
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Book> pageByName(String name, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM book WHERE name LIKE ? ORDER BY id DESC LIMIT ? OFFSET ?";
        try {
            List<Book> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(Book.class), "%" + name + "%", pageSize, offset);
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Book> findTopRecommend() {
        String sql = "SELECT * FROM book ORDER BY id DESC LIMIT 8";
        try {
            List<Book> list = queryRunner.query(sql, DbUtilsConfig.newBeanListHandler(Book.class));
            return list != null ? list : Collections.emptyList();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public long count() {
        String sql = "SELECT COUNT(*) FROM book";
        try {
            Number num = queryRunner.query(sql, new ScalarHandler<>());
            return num != null ? num.longValue() : 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public long countByCategory(String category) {
        String sql = "SELECT COUNT(*) FROM book WHERE category = ?";
        try {
            Number num = queryRunner.query(sql, new ScalarHandler<>(), category);
            return num != null ? num.longValue() : 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public long countByName(String name) {
        String sql = "SELECT COUNT(*) FROM book WHERE name LIKE ?";
        try {
            Number num = queryRunner.query(sql, new ScalarHandler<>(), "%" + name + "%");
            return num != null ? num.longValue() : 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Long insert(Book book) {
        String sql = "INSERT INTO book (name, author, description, category, image, price, stock, create_time, update_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            queryRunner.update(sql,
                    book.getName(), book.getAuthor(), book.getDescription(),
                    book.getCategory(), book.getImage(), book.getPrice(),
                    book.getStock(), book.getCreateTime(), book.getUpdateTime());
            return 1L;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean update(Book book) {
        String sql = "UPDATE book SET name = ?, author = ?, description = ?, category = ?, image = ?, price = ?, stock = ?, update_time = ? WHERE id = ?";
        try {
            int rows = queryRunner.update(sql,
                    book.getName(), book.getAuthor(), book.getDescription(),
                    book.getCategory(), book.getImage(), book.getPrice(),
                    book.getStock(), book.getUpdateTime(), book.getId());
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean delete(Long id) {
        String sql = "DELETE FROM book WHERE id = ?";
        try {
            int rows = queryRunner.update(sql, id);
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean updateStock(Long bookId, int number) {
        String sql = "UPDATE book SET stock = stock - ? WHERE id = ?";
        try {
            int rows = queryRunner.update(sql, number, bookId);
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}


