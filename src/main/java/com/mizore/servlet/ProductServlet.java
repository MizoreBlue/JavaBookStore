package com.mizore.servlet;

import com.mizore.dao.impl.BookDAOImpl;
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

@WebServlet(urlPatterns = "/product/*")
public class ProductServlet extends HttpServlet {

    private BookService bookService = new BookServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 查看商品列表
        String uri = req.getRequestURI();
        if (uri.contains("/list")) {
            listBooks(req, resp);
        }
        // 这里可以扩展 details, search 等操作
    }


    /**
     * 查询所有图书
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    private void listBooks(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Book> books = bookService.findAllBooks();
//        设置请求体
        req.setAttribute("productList", books);
        // 转发到首页显示 携带数据
        req.getRequestDispatcher("/WEB-INF/views/client/product_list.jsp").forward(req, resp);
    }
}