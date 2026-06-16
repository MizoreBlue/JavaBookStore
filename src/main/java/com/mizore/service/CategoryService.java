package com.mizore.service;

import com.mizore.dao.CategoryDAO;
import com.mizore.entity.Category;
import com.mizore.utils.PageResult;

import java.time.LocalDateTime;
import java.util.List;

public class CategoryService {

    private CategoryDAO categoryDAO = ServiceFactory.getCategoryDAO();

    public List<Category> list() {
        return categoryDAO.findAll();
    }

    public PageResult<Category> page(int page, int pageSize) {
        if (page < 1) page = 1;
        return PageResult.of(categoryDAO.page(page, pageSize), categoryDAO.count(), page, pageSize);
    }

    public Category getById(Long id) {
        return categoryDAO.findById(id);
    }

    public Long add(Category category) {
        category.setCreateTime(LocalDateTime.now());
        category.setUpdateTime(LocalDateTime.now());
        return categoryDAO.insert(category);
    }

    public boolean update(Category category) {
        category.setUpdateTime(LocalDateTime.now());
        return categoryDAO.update(category);
    }

    public boolean delete(Long id) {
        return categoryDAO.delete(id);
    }
}
