package com.mizore.service.impl;

import com.mizore.dao.BookDAO;
import com.mizore.dao.UserDAO;
import com.mizore.dao.impl.BookDAOImpl;
import com.mizore.dao.impl.UserDAOImpl;
import com.mizore.entity.Book;
import com.mizore.entity.User;
import com.mizore.service.BookService;
import com.mizore.service.UserService;

import java.util.List;

public class UserServiceImpl implements UserService {

    private UserDAO userDAO = new UserDAOImpl();

    /**
     * 用户注册
     * @param user
     */
    public void register(User user) {
        userDAO.register(user);
    }


    /**
     * 用户登录
     * @param user
     */
    public boolean login(User user) {
        User u = userDAO.getUser(user.getUsername());

        if (u != null) {
//            比对用户密码
            return u.getPassword().equals(user.getPassword());
        }
        return false;
    }
}
