<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    String ctx = request.getContextPath();
    if (ctx.equals("/") || ctx.equals("")) {
        ctx = "";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品列表</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f5f5f5; }
        .header { background-color: #4CAF50; padding: 15px; color: white; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 24px; font-weight: bold; }
        .nav a { color: white; margin-left: 20px; text-decoration: none; }
        .search-bar { display: flex; gap: 10px; }
        .search-bar input { padding: 8px; border: none; border-radius: 4px; }
        .search-bar button { padding: 8px 16px; background-color: #fff; color: #4CAF50; border: none; border-radius: 4px; cursor: pointer; }
        .container { max-width: 1200px; margin: 20px auto; }
        .products { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
        .product-card { background: white; padding: 15px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .product-card img { width: 100%; height: 200px; object-fit: cover; border-radius: 4px; }
        .product-name { font-weight: bold; margin: 10px 0; }
        .product-author { color: #666; font-size: 14px; }
        .product-price { color: #f44336; font-size: 18px; font-weight: bold; }
        .btn-add { background-color: #4CAF50; color: white; padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; width: 100%; }
        .btn-add:hover { opacity: 0.8; }
        .category-filter { margin-bottom: 15px; }
        .category-filter a { margin-right: 10px; padding: 5px 10px; background: white; border-radius: 4px; text-decoration: none; color: #333; }
        .category-filter a.active { background-color: #4CAF50; color: white; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo"><a href="<%=ctx%>/" style="color: white; text-decoration: none;">图书商城</a></div>
            <div class="nav">
                <a href="<%=ctx%>/product/list">商品列表</a>
                <a href="<%=ctx%>/cart?action=view">购物车</a>
                <a href="<%=ctx%>/order/list">我的订单</a>
                <c:if test="${sessionScope.user != null}">
                    <a href="<%=ctx%>/user/profile">欢迎: ${sessionScope.user.username}</a>
                    <a href="<%=ctx%>/user/logout">退出</a>
                </c:if>
                <c:if test="${sessionScope.user == null}">
                    <a href="<%=ctx%>/user/login">登录</a>
                </c:if>
            </div>
            <form class="search-bar" onsubmit="return search()">
                <input type="text" id="keyword" placeholder="搜索书名或作者">
                <button type="submit">搜索</button>
            </form>
        </div>
    </div>
    <div class="container">
        <div class="category-filter">
            <a href="<%=ctx%>/product/list" ${category == null ? 'class="active"' : ''}>全部</a>
            <a href="<%=ctx%>/product/list?category=文学小说" ${category == '文学小说' ? 'class="active"' : ''}>文学小说</a>
            <a href="<%=ctx%>/product/list?category=科技科普" ${category == '科技科普' ? 'class="active"' : ''}>科技科普</a>
            <a href="<%=ctx%>/product/list?category=历史传记" ${category == '历史传记' ? 'class="active"' : ''}>历史传记</a>
            <a href="<%=ctx%>/product/list?category=经济管理" ${category == '经济管理' ? 'class="active"' : ''}>经济管理</a>
            <a href="<%=ctx%>/product/list?category=儿童读物" ${category == '儿童读物' ? 'class="active"' : ''}>儿童读物</a>
        </div>
        <div class="products">
            <c:forEach var="book" items="${books}">
                <div class="product-card">
                    <img src="<c:choose><c:when test="${not empty book.image}">${book.image}</c:when><c:otherwise><%=ctx%>/static/images/no-image.png</c:otherwise></c:choose>" alt="${book.name}" onerror="this.onerror=null;this.src='<%=ctx%>/static/images/no-image.png';">
                    <div class="product-name">${book.name}</div>
                    <div class="product-author">作者：${book.author}</div>
                    <div class="product-price">¥${book.price}</div>
                    <button class="btn-add" onclick="addToCart(${book.id})">加入购物车</button>
                </div>
            </c:forEach>
            <c:if test="${empty books}">
                <div style="grid-column: 1/-1; text-align: center; padding: 40px; color: #999;">
                    <p style="font-size: 18px;">暂无商品</p>
                </div>
            </c:if>
        </div>
    </div>
    <script>
        var contextPath = '<%=ctx%>';
        function search() {
            var keyword = document.getElementById('keyword').value;
            if (keyword) {
                location.href = contextPath + '/product/list?keyword=' + encodeURIComponent(keyword);
            }
            return false;
        }
        function addToCart(bookId) {
            fetch(contextPath + '/cart/add', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'bookId=' + bookId + '&quantity=1'
            }).then(function(res) { return res.json(); }).then(function(data) {
                alert(data.message);
            });
        }
    </script>
</body>
</html>