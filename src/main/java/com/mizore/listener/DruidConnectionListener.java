package com.mizore.listener;

import com.mizore.utils.DruidUtils;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Connection;
import java.util.logging.Logger;

/**
 * 数据库连接池初始化监听器
 * 在应用启动时验证数据库连接池可用性
 */
@WebListener
public class DruidConnectionListener implements ServletContextListener {

    private static final Logger logger = Logger.getLogger(DruidConnectionListener.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            Connection conn = DruidUtils.getConnection();
            if (conn != null) {
                logger.info("数据库连接池初始化成功");
                conn.close();
            }
            sce.getServletContext().setAttribute("dataSource", DruidUtils.getDataSource());
        } catch (Exception e) {
            logger.severe("数据库连接池初始化失败: " + e.getMessage());
            throw new RuntimeException("数据库连接池初始化失败", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (DruidUtils.getDataSource() != null) {
            DruidUtils.getDataSource().close();
            logger.info("数据库连接池已关闭");
        }
    }
}