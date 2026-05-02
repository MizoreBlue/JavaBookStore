package com.mizore.dao;

import com.mizore.entity.Book;

import java.util.List;

public interface BookDAO {


    /**
     * 查到所有书籍信息
     * @return
     */
    List<Book> findAll();


    /**
     * 插入一条数据
     * @param book
     * @return
     */
    boolean insert(Book book);


    /**
     * 模糊查询
     * @param keyword
     * @return
     */
    List<Book> findByKeyword(String keyword);
}
