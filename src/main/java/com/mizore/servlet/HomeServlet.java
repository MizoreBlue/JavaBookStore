package com.mizore.servlet;

import com.mizore.entity.Book;
import com.mizore.entity.Category;
import com.mizore.service.BookService;
import com.mizore.service.CategoryService;
import com.mizore.utils.PageResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/", "/index"})
public class HomeServlet extends HttpServlet {

    private BookService bookService = new BookService();
    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryService.list();
        List<Book> recommendBooks = bookService.getRecommend();
        PageResult<Book> newBooks = bookService.page(1, 12, null, null);
        request.setAttribute("categories", categories);
        request.setAttribute("recommendBooks", recommendBooks);
        request.setAttribute("newBooks", newBooks.getRecords());
        request.getRequestDispatcher("/WEB-INF/views/front/index.jsp").forward(request, response);
    }
}
