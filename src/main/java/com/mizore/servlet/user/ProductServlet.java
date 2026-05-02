package com.mizore.servlet.user;

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
            List<Book> books = bookService.findAllBooks();
//            设置请求体
            req.setAttribute("productList", books);
//            请全体携带数据转发请求
            req.getRequestDispatcher("/WEB-INF/views/client/product_list.jsp").forward(req, resp);

        }


//        查询商品
        if (uri.contains("/search")) {
//            请求参数
            String keyword = req.getParameter("keyword");
//            模糊查询结果
            List<Book> bookList = bookService.findBookByKeyword(keyword);
            req.setAttribute("productList", bookList);
//            结合数据返回页面 ssr
            req.getRequestDispatcher("/WEB-INF/views/client/product_list.jsp").forward(req, resp);
        }
    }


}