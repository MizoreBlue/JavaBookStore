package com.mizore.servlet.admin;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(urlPatterns = "/backend/*")
public class BackendServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//        获取请求路径
        String uri = request.getRequestURI();

        if(uri.equals("/")){
//            转发到后端首页
            request.getRequestDispatcher("/WEB-INF/views/admin/home.jsp").forward(request,response);
        }


    }

}
