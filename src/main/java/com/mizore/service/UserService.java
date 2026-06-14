package com.mizore.service;

import com.mizore.dao.UserDAO;
import com.mizore.entity.User;
import com.mizore.utils.PageResult;

import java.time.LocalDateTime;

public class UserService {

    private UserDAO userDAO = ServiceFactory.getUserDAO();

    public User login(String username, String password) {
        User user = userDAO.getUser(username);
        if (user != null && password != null && password.equals(user.getPassword())) {
            return user;
        }
        return null;
    }

    public boolean register(User user) {
        User exist = userDAO.getUser(user.getUsername());
        if (exist != null) {
            return false;
        }
        user.setCreateTime(LocalDateTime.now());
        userDAO.register(user);
        return true;
    }

    public User getById(Long id) {
        return userDAO.getById(id);
    }

    public PageResult<User> page(int page, int pageSize) {
        if (page < 1) page = 1;
        return PageResult.of(userDAO.page(page, pageSize), userDAO.count(), page, pageSize);
    }

    public boolean update(User user) {
        return userDAO.update(user);
    }

    public boolean delete(Long id) {
        return userDAO.delete(id);
    }
}
