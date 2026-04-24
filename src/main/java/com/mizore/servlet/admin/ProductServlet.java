package com.mizore.servlet.admin;


import com.mizore.entity.Book;
import com.mizore.service.BookService;
import com.mizore.service.impl.BookServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/backend/product/*")
public class ProductServlet extends HttpServlet {

    private BookService bookService = new BookServiceImpl();


    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/list")) {
//            获取管理端商品列表
            List<Book> products = bookService.findAllBooks();
//           设置请求头
            req.setAttribute("products", products);

            req.getRequestDispatcher("/WEB-INF/views/admin/home.jsp").forward(req, resp);

        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
