package com.mizore.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class StaticResourceFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        if (uri.endsWith(".css")) {
            resp.setContentType("text/css");
        } else if (uri.endsWith(".js")) {
            resp.setContentType("application/javascript");
        } else if (uri.endsWith(".png") || uri.endsWith(".jpg") || uri.endsWith(".jpeg") || uri.endsWith(".gif")) {
            resp.setContentType("image/" + uri.substring(uri.lastIndexOf(".") + 1));
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}