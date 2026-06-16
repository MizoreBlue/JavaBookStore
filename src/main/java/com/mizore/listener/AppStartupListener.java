package com.mizore.listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebListener
public class AppStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String startupTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        sce.getServletContext().setAttribute("startupTime", startupTime);
        sce.getServletContext().setAttribute("appName", "Java Book Store");
        sce.getServletContext().setAttribute("onlineCount", 0);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
