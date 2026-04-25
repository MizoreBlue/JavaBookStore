package com.mizore.service;

import com.mizore.entity.Book;

import java.util.List;

public interface BookService {

    /**
     * 查找全部书籍数据
     * @return
     */
    List<Book> findAllBooks();


    /**
     * 插入一条数据
     * @param book
     * @return
     */
    boolean insert(Book book);
}
