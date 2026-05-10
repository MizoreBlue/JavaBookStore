package com.mizore.listener;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import lombok.Getter;

@WebListener
public class OnlineUserListener implements HttpSessionListener {

    // JSP 需要通过这个静态方法获取人数
    @Getter
    private static int onlineCount = 0;

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        onlineCount++;
        System.out.println("Session 创建，当前在线：" + onlineCount);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        if (onlineCount > 0) {
            onlineCount--;
        }
        System.out.println("Session 销毁，当前在线：" + onlineCount);
    }

}