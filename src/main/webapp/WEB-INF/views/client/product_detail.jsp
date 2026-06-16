<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>${book.name}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f5f5f5; }
        .header { background-color: #4CAF50; padding: 15px; color: white; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 24px; font-weight: bold; }
        .nav a { color: white; margin-left: 20px; text-decoration: none; }
        .container { max-width: 1000px; margin: 30px auto; }
        .product-detail { display: flex; gap: 30px; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .product-image { width: 300px; height: 400px; object-fit: cover; border-radius: 8px; }
        .product-info { flex: 1; }
        .product-title { font-size: 28px; font-weight: bold; margin-bottom: 20px; }
        .product-author { font-size: 18px; color: #666; margin-bottom: 10px; }
        .product-category { display: inline-block; background-color: #f1f1f1; padding: 5px 10px; border-radius: 4px; margin-bottom: 20px; }
        .product-price { font-size: 32px; color: #f44336; font-weight: bold; margin-bottom: 20px; }
        .product-stock { color: #666; margin-bottom: 20px; }
        .product-desc { line-height: 1.8; color: #333; }
        .quantity-control { display: flex; align-items: center; gap: 10px; margin-bottom: 20px; }
        .quantity-control button { width: 30px; height: 30px; font-size: 18px; }
        .quantity-control input { width: 50px; text-align: center; }
        .btn-add { background-color: #4CAF50; color: white; padding: 12px 30px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .btn-add:hover { opacity: 0.8; }
        .btn-back { background-color: #f1f1f1; color: #333; padding: 12px 30px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; margin-left: 10px; }
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
            </div>
        </div>
    </div>
    <div class="container">
        <c:choose>
            <c:when test="${not empty book}">
                <div class="product-detail">
                    <img src="<c:choose><c:when test="${not empty book.image}">${book.image}</c:when><c:otherwise><%=ctx%>/static/images/no-image.png</c:otherwise></c:choose>" class="product-image" onerror="this.onerror=null;this.src='<%=ctx%>/static/images/no-image.png';">
                    <div class="product-info">
                        <h1 class="product-title">${book.name}</h1>
                        <div class="product-author">作者：${book.author}</div>
                        <div class="product-category">${book.category}</div>
                        <div class="product-price">¥${book.price}</div>
                        <div class="product-stock">库存：${book.stock}本</div>
                        <div class="quantity-control">
                            <button onclick="changeQuantity(-1)">-</button>
                            <input type="number" id="quantity" value="1" min="1" max="${book.stock}">
                            <button onclick="changeQuantity(1)">+</button>
                        </div>
                        <button class="btn-add" onclick="addToCart(${book.id})">加入购物车</button>
                        <button class="btn-back" onclick="history.back()">返回列表</button>
                        <div class="product-desc"><h3>简介：</h3>${book.description}</div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; padding: 60px; background: white; border-radius: 8px;">
                    <h2 style="color: #f44336;">商品不存在或已下架</h2>
                    <a href="<%=ctx%>/product/list" style="display: inline-block; margin-top: 20px; padding: 10px 20px; background: #4CAF50; color: white; text-decoration: none; border-radius: 4px;">返回商品列表</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <script>
        var contextPath = '<%=ctx%>';
        function changeQuantity(delta) {
            var input = document.getElementById('quantity');
            var value = parseInt(input.value);
            value += delta;
            if (value < 1) value = 1;
            input.value = value;
        }
        function addToCart(bookId) {
            var quantity = document.getElementById('quantity').value;
            fetch(contextPath + '/cart/add', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'bookId=' + bookId + '&quantity=' + quantity
            }).then(function(res) { return res.json(); }).then(function(data) {
                alert(data.message);
            });
        }
    </script>
</body>
</html>