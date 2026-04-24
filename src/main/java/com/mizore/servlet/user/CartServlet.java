package com.mizore.servlet.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = "/cart/*")
public class CartServlet extends HttpServlet {

    // GET 请求：查看购物车
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        // 这里可以添加从数据库加载用户购物车的逻辑
        // 目前我们只处理 Session 中的临时购物车
        String uri = req.getRequestURI();

//        展示购物车
        if (uri.contains("list")) {
            req.getRequestDispatcher("/WEB-INF/views/client/shop_cart.jsp").forward(req, resp);
        }

    }

    // POST 请求：添加商品到购物车
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");

        // 1. 获取参数
        String name = req.getParameter("PName");
        String price = req.getParameter("Price");
        String image = req.getParameter("Image");

        if (name == null || price == null) {
            resp.sendError(400, "参数缺失");
            return;
        }

        // 2. 封装商品
        Map<String, String> item = new HashMap<>();
        item.put("name", name);
        item.put("price", price);
        item.put("image", image);

        // 3. 存入 Session
        HttpSession session = req.getSession();
        List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        cart.add(item);

        // 4. 重定向（防止表单重复提交）
        // 这里重定向回商品列表
        resp.sendRedirect(req.getContextPath() + "/product?action=list");
    }

}