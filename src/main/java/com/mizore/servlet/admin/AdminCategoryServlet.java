package com.mizore.servlet.admin;

import com.mizore.entity.Category;
import com.mizore.entity.Employee;
import com.mizore.service.CategoryService;
import com.mizore.utils.PageResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/backend/category")
public class AdminCategoryServlet extends HttpServlet {

    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Employee employee = (Employee) request.getSession().getAttribute("employee");
        if (employee == null) {
            response.sendRedirect(request.getContextPath() + "/backend/login");
            return;
        }
        String action = request.getParameter("action");
        if (action == null) action = "list";
        switch (action) {
            case "add":
                request.getRequestDispatcher("/WEB-INF/views/admin/category_edit.jsp").forward(request, response);
                break;
            case "edit":
                Long id = parseLong(request.getParameter("id"));
                if (id != null) {
                    Category c = categoryService.getById(id);
                    request.setAttribute("category", c);
                }
                request.getRequestDispatcher("/WEB-INF/views/admin/category_edit.jsp").forward(request, response);
                break;
            case "save":
                Category category = Category.builder()
                        .name(request.getParameter("name"))
                        .type(parseInt(request.getParameter("type"), 1))
                        .sort(parseInt(request.getParameter("sort"), 0))
                        .status(parseInt(request.getParameter("status"), 1))
                        .build();
                Long editId = parseLong(request.getParameter("id"));
                if (editId != null && editId > 0) {
                    category.setId(editId);
                    categoryService.update(category);
                } else {
                    categoryService.add(category);
                }
                response.sendRedirect(request.getContextPath() + "/backend/category");
                break;
            case "delete":
                Long delId = parseLong(request.getParameter("id"));
                if (delId != null) {
                    categoryService.delete(delId);
                }
                response.sendRedirect(request.getContextPath() + "/backend/category");
                break;
            default:
                int page = parseInt(request.getParameter("page"), 1);
                int pageSize = parseInt(request.getParameter("pageSize"), 10);
                PageResult<Category> pageResult = categoryService.page(page, pageSize);
                request.setAttribute("pageResult", pageResult);
                request.getRequestDispatcher("/WEB-INF/views/admin/category_list.jsp").forward(request, response);
        }
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
