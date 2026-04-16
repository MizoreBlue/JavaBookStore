package com.mizore.dao;

import com.mizore.entity.Book;
import com.mizore.entity.User;

import java.util.List;

public interface UserDAO {


    /**
     * 用户登录
     * @param user
     */
    void register(User user);

    User getUser(String username);
}
