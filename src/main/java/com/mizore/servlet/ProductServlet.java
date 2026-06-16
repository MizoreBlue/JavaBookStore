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

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    private BookService bookService = new BookService();
    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("detail".equals(action)) {
            showDetail(request, response);
        } else {
            listBooks(request, response);
        }
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = parseInt(request.getParameter("page"), 1);
        int pageSize = parseInt(request.getParameter("pageSize"), 12);
        String category = request.getParameter("category");
        String keyword = request.getParameter("keyword");
        List<Category> categories = categoryService.list();
        PageResult<Book> pageResult = bookService.page(page, pageSize, category, keyword);
        request.setAttribute("categories", categories);
        request.setAttribute("pageResult", pageResult);
        request.setAttribute("currentCategory", category);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/WEB-INF/views/front/product_list.jsp").forward(request, response);
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = parseLong(request.getParameter("id"));
        Book book = bookService.getById(id);
        if (book == null) {
            response.sendRedirect(request.getContextPath() + "/product");
            return;
        }
        request.setAttribute("book", book);
        request.getRequestDispatcher("/WEB-INF/views/front/product_detail.jsp").forward(request, response);
    }

    private int parseInt(String s, int defaultValue) {
        try {
            return s == null ? defaultValue : Integer.parseInt(s);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private Long parseLong(String s) {
        try {
            return s == null ? null : Long.parseLong(s);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
