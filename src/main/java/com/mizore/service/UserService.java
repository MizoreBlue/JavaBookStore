package com.mizore.service;

import com.mizore.entity.User;

public interface UserService {

    /**
     * 用户注册
     * @param user
     */
    boolean register(User user);


    /**
     * 用户登录
     * @param user
     */
    boolean login(User user);
}
