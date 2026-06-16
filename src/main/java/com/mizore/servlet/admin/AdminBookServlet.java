package com.mizore.servlet.admin;

import com.mizore.entity.Book;
import com.mizore.entity.Category;
import com.mizore.service.BookService;
import com.mizore.service.CategoryService;
import com.mizore.utils.PageResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

@WebServlet({"/backend/book", "/backend/book/*"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class AdminBookServlet extends HttpServlet {

    private BookService bookService = new BookService();
    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";
        switch (action) {
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "save":
                handleSave(request, response);
                break;
            case "delete":
                handleDelete(request, response);
                break;
            case "logout":
                request.getSession().removeAttribute("employee");
                response.sendRedirect(request.getContextPath() + "/backend/login");
                break;
            default:
                listBooks(request, response);
        }
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = parseInt(request.getParameter("page"), 1);
        int pageSize = parseInt(request.getParameter("pageSize"), 10);
        String keyword = request.getParameter("keyword");
        PageResult<Book> pageResult = bookService.page(page, pageSize, null, keyword);
        request.setAttribute("pageResult", pageResult);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/WEB-INF/views/admin/book_list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryService.list();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/admin/book_edit.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = parseLong(request.getParameter("id"));
        Book book = bookService.getById(id);
        List<Category> categories = categoryService.list();
        request.setAttribute("book", book);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/admin/book_edit.jsp").forward(request, response);
    }

    private void handleSave(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = parseLong(request.getParameter("id"));
        String name = request.getParameter("name");
        String author = request.getParameter("author");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String oldImage = request.getParameter("oldImage");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");

        String imagePath = oldImage;
        Part filePart = request.getPart("imageFile");
        if (filePart != null && filePart.getSize() > 0) {
            String submittedName = filePart.getSubmittedFileName();
            String ext = "";
            if (submittedName != null && submittedName.lastIndexOf(".") > 0) {
                ext = submittedName.substring(submittedName.lastIndexOf("."));
            }
            String fileName = UUID.randomUUID().toString().replace("-", "") + ext;

            String uploadDir = getServletContext().getRealPath("/uploads/book");
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            Path target = new File(dir, fileName).toPath();
            Files.copy(filePart.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);
            imagePath = "/uploads/book/" + fileName;
        }

        Book book = Book.builder()
                .name(name)
                .author(author)
                .description(description)
                .category(category)
                .image(imagePath)
                .build();
        try {
            book.setPrice(new BigDecimal(priceStr));
        } catch (Exception e) {
            book.setPrice(BigDecimal.ZERO);
        }
        try {
            book.setStock(Integer.parseInt(stockStr));
        } catch (Exception e) {
            book.setStock(0);
        }
        if (id != null && id > 0) {
            book.setId(id);
            bookService.update(book);
        } else {
            bookService.add(book);
        }
        response.sendRedirect(request.getContextPath() + "/backend/book");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = parseLong(request.getParameter("id"));
        if (id != null) {
            bookService.delete(id);
        }
        response.sendRedirect(request.getContextPath() + "/backend/book");
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
