package com.mizore.dao;

import com.mizore.entity.Category;

import java.util.List;

public interface CategoryDAO {
    Category findById(Long id);
    List<Category> findAll();
    List<Category> page(int page, int pageSize);
    long count();
    Long insert(Category category);
    boolean update(Category category);
    boolean delete(Long id);
}
