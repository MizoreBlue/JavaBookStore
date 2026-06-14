package com.mizore.listener;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

import java.util.concurrent.atomic.AtomicInteger;

@WebListener
public class OnlineUserListener implements HttpSessionListener {

    private static final AtomicInteger onlineCount = new AtomicInteger(0);

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        onlineCount.incrementAndGet();
        se.getSession().getServletContext().setAttribute("onlineCount", onlineCount.get());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        onlineCount.decrementAndGet();
        se.getSession().getServletContext().setAttribute("onlineCount", onlineCount.get());
    }

    public static int getOnlineCount() {
        return onlineCount.get();
    }
}
