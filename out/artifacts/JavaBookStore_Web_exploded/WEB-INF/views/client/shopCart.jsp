<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>我的购物车</title>
    <style>
        body { font-family: "Microsoft YaHei", sans-serif; background-color: #f4f4f4; }
        .container { width: 800px; margin: 50px auto; background: #fff; padding: 20px; border: 1px solid #ddd; }
        h2 { border-bottom: 2px solid #ff6700; padding-bottom: 10px; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #eee; padding: 10px; text-align: center; }
        th { background-color: #f9f9f9; }
        .empty-cart { text-align: center; color: #999; margin-top: 50px; }
        .btn-back { display: inline-block; margin-top: 20px; padding: 10px 20px; background: #ff6700; color: white; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>

<div class="container">
    <h2>购物车详情</h2>

    <%
        // 1. 从 session 获取购物车集合 TODO 采用数据库实现购物车
        List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");
    %>

    <!-- 2. 遍历商品条目 -->
    <% if (cart == null || cart.isEmpty()) { %>
    <!-- 购物车为空的情况 -->
    <div class="empty-cart">
        <h3>购物车空空如也，快去选购吧！</h3>
        <a href="productList" class="btn-back">去购物</a>
    </div>
    <% } else { %>
    <!-- 购物车有商品的情况 -->
    <table>
        <thead>
        <tr>
            <th>序号</th>
            <th>商品图片</th>
            <th>商品名称</th>
            <th>单价</th>
            <th>总价</th>
            <th>数量</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%
            // 使用增强 for 循环遍历 cart
            int i = 0;
            for (Map<String, String> item : cart) {
                i++;
        %>
        <tr>
            <td><%= i %></td>
            <td>
                <!-- 假设图片都在 assets/images/productImg 下 -->
                <img src="${pageContext.request.contextPath}/assets/images/productImg/<%= item.get("image") %>" width="50">
            </td>
            <td><%= item.get("name") %></td>
            <td style="color: #ff6700;">¥<%= item.get("price") %></td>
            <td><%= item.get("num") %></td>
            <td>
                <a href="#">删除</a> <!-- 这里后续可以链接到 DeleteCart.jsp -->
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <div style="text-align: right; margin-top: 20px;">
        <a href="productList" class="btn-back" style="background: #666;">继续购物</a>
    </div>
    <% } %>
</div>

</body>
</html>