package com.mizore.service.impl;

import com.mizore.dao.BookDAO;
import com.mizore.dao.impl.BookDAOImpl;
import com.mizore.entity.Book;
import com.mizore.service.BookService;

import java.util.List;

public class BookServiceImpl implements BookService {


    private BookDAO bookDAO = new BookDAOImpl();

    /**
     * 查找全部书籍数据
     *
     * @return
     */
    public List<Book> findAllBooks() {
        return bookDAO.findAll();
    }


    /**
     * 插入一条数据
     *
     * @param book
     * @return
     */
    public boolean insert(Book book) {
        return bookDAO.insert(book);
    }


    /**
     * 模糊查询图书
     * @param keyword
     * @return
     */
    public List<Book> findBookByKeyword(String keyword) {
        return bookDAO.findByKeyword(keyword);
    }
}
