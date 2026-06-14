package com.mizore.dao;

import com.mizore.entity.User;

import java.util.List;

public interface UserDAO {
    User getUser(String username);
    User getById(Long id);
    List<User> list();
    List<User> page(int page, int pageSize);
    long count();
    void register(User user);
    boolean update(User user);
    boolean delete(Long id);
}
