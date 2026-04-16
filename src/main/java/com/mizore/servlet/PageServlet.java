package com.mizore.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// 统一管理页面跳转，不负责业务逻辑
@WebServlet(urlPatterns = {"/"})
public class PageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 获取 action 参数，例如 /page?action=home
        String action = req.getParameter("action");
        String path = getString(action);

        if (path != null) {
            try {
                RequestDispatcher rd = req.getRequestDispatcher(path);
                rd.forward(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendError(500, "页面跳转失败");
            }
        } else {
            resp.sendError(404, "页面未找到");
        }
    }

    private static String getString(String action) {
        String path = null;

        if (action == null || "home".equals(action)) {
            path = "/WEB-INF/views/client/index.jsp";
        } else if ("register".equals(action)) {
            path = "/WEB-INF/views/client/register.jsp";
        } else if ("cart".equals(action)) {
            // 注意：查看购物车通常需要先查询数据，这里只是简单跳转
            // 更好的做法是交给 CartServlet 处理查询后再转发
            path = "/WEB-INF/views/client/shop_cart.jsp";
        } else if ("admin_home".equals(action)) {
            path = "/WEB-INF/views/admin/home.jsp";
        }
        return path;
    }
}