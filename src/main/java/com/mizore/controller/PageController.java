package com.mizore.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/", "/index", "/register", "/first", "/admin/home"})
public class PageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String uri = req.getRequestURI();
        // 获取项目路径（比如 /JavaBookStore）
        String contextPath = req.getContextPath();

        // --- 关键修改点：显式放行静态资源 ---
        if (uri.contains("/assets")) {
            // 截取 /assets 及其后面的部分
            // 比如 uri 是 /JavaBookStore/assets/css/style.css
            // 我们要截取成 /assets/css/style.css
            String resourcePath = uri.substring(contextPath.length());

            try {
                // 获取 Tomcat 的默认 Servlet (名字叫 "default")
                RequestDispatcher rd = req.getServletContext().getNamedDispatcher("default");
                // 转发请求给它，它会去读取文件
                rd.forward(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendError(500, "静态资源读取失败");
            }
            return; // 转发后必须 return，不要再往下执行
        }
        // --- 关键修改点结束 ---

        // --- 页面跳转逻辑 ---
        if (uri.contains("/index") || uri.endsWith(contextPath + "/")) {
            forward(req, resp, "/WEB-INF/views/client/index.jsp");
        } else if (uri.contains("/register")) {
            forward(req, resp, "/WEB-INF/views/client/register.jsp");
        } else if (uri.contains("/first")) {
            forward(req, resp, "/WEB-INF/views/admin/login/first.jsp");
        }  else if(uri.contains("/admin/home")){
            forward(req, resp, "/WEB-INF/views/admin/home.jsp");
        } else {
            resp.sendError(404, "页面未找到: " + uri);
        }
    }

    private void forward(HttpServletRequest req, HttpServletResponse resp, String path) {
        try {
            req.getRequestDispatcher(path).forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            try {
                resp.sendError(500, "服务器内部错误: " + e.getMessage());
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }
}