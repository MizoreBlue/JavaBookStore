package com.mizore.dao;

import com.mizore.entity.Book;

import java.util.List;

public interface BookDAO {
    Book findById(Long id);
    List<Book> findAll();
    List<Book> findByCategory(String category);
    List<Book> findByName(String name);
    List<Book> page(int page, int pageSize);
    List<Book> pageByCategory(String category, int page, int pageSize);
    List<Book> pageByName(String name, int page, int pageSize);
    List<Book> findTopRecommend();
    long count();
    long countByCategory(String category);
    long countByName(String name);
    Long insert(Book book);
    boolean update(Book book);
    boolean delete(Long id);
    boolean updateStock(Long bookId, int number);
}
