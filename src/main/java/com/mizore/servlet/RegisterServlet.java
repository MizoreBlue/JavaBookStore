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

@WebServlet(urlPatterns = "/register/*")
public class RegisterServlet extends HttpServlet {
    private BookDAOImpl bookDAO = new BookDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/client/register.jsp").forward(req, resp);
    }
}