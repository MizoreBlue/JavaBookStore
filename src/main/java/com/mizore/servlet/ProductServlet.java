package com.mizore.servlet;

import com.mizore.dao.impl.BookDAOImpl;
import com.mizore.entity.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/product/*")
public class ProductServlet extends HttpServlet {
    private BookDAOImpl bookDAO = new BookDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        根据请求路径区分操作类型
        // 获取操作类型，默认为列表
        String uri = req.getRequestURI();
        if (uri.contains("/list")) {
            listBooks(req, resp);
        }
        // 这里可以扩展 details, search 等操作
    }

    private void listBooks(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Book> books = bookDAO.findAll();
        req.setAttribute("productList", books);
        // 转发到首页显示
        req.getRequestDispatcher("/WEB-INF/views/client/productList.jsp").forward(req, resp);
    }
}