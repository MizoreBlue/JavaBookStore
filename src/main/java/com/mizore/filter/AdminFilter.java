package com.mizore.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter(filterName = "AdminFilter", urlPatterns = {"/backend/home", "/backend/book", "/backend/book/*", "/backend/order", "/backend/user", "/backend/category"})
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        Object employee = req.getSession().getAttribute("employee");
        if (employee == null) {
            HttpServletResponse res = (HttpServletResponse) response;
            res.sendRedirect(req.getContextPath() + "/backend/login");
            return;
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
