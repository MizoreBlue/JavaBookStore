package com.mizore.service;

import com.mizore.dao.BookDAO;
import com.mizore.entity.Book;
import com.mizore.utils.PageResult;

import java.time.LocalDateTime;
import java.util.List;

public class BookService {

    private BookDAO bookDAO = ServiceFactory.getBookDAO();

    public PageResult<Book> page(int page, int pageSize, String category, String keyword) {
        if (page < 1) page = 1;
        List<Book> records;
        long total;
        if (keyword != null && !keyword.trim().isEmpty()) {
            records = bookDAO.pageByName(keyword.trim(), page, pageSize);
            total = bookDAO.countByName(keyword.trim());
        } else if (category != null && !category.trim().isEmpty()) {
            records = bookDAO.pageByCategory(category.trim(), page, pageSize);
            total = bookDAO.countByCategory(category.trim());
        } else {
            records = bookDAO.page(page, pageSize);
            total = bookDAO.count();
        }
        return PageResult.of(records, total, page, pageSize);
    }

    public Book getById(Long id) {
        return bookDAO.findById(id);
    }

    public List<Book> getRecommend() {
        return bookDAO.findTopRecommend();
    }

    public List<Book> findAll() {
        return bookDAO.findAll();
    }

    public Long add(Book book) {
        book.setCreateTime(LocalDateTime.now());
        book.setUpdateTime(LocalDateTime.now());
        return bookDAO.insert(book);
    }

    public boolean update(Book book) {
        book.setUpdateTime(LocalDateTime.now());
        return bookDAO.update(book);
    }

    public boolean delete(Long id) {
        return bookDAO.delete(id);
    }
}
