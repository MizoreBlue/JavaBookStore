<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>购物车</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f5f5f5; }
        .header { background-color: #4CAF50; padding: 15px; color: white; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 24px; font-weight: bold; }
        .nav a { color: white; margin-left: 20px; text-decoration: none; }
        .container { max-width: 1000px; margin: 30px auto; }
        h2 { color: #333; margin-bottom: 20px; }
        .cart-empty { background: white; padding: 50px; text-align: center; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .cart-table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .cart-table th, .cart-table td { padding: 15px; text-align: left; border-bottom: 1px solid #ddd; }
        .cart-table th { background-color: #f8f8f8; }
        .cart-table img { width: 80px; height: 100px; object-fit: cover; }
        .price { color: #f44336; font-weight: bold; }
        .quantity-control { display: flex; align-items: center; gap: 5px; }
        .quantity-control button { width: 25px; height: 25px; }
        .quantity-control input { width: 40px; text-align: center; }
        .btn { padding: 8px 16px; border: none; cursor: pointer; border-radius: 4px; }
        .btn-delete { background-color: #f44336; color: white; }
        .btn-checkout { background-color: #4CAF50; color: white; padding: 12px 30px; font-size: 16px; float: right; margin-top: 20px; }
        .btn-clear { background-color: #f1f1f1; color: #333; margin-right: 10px; }
        .total-row { text-align: right; font-weight: bold; }
        .total-row td { padding-top: 20px; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo"><a href="<%=ctx%>/" style="color: white; text-decoration: none;">图书商城</a></div>
            <div class="nav">
                <a href="<%=ctx%>/product/list">商品列表</a>
                <a href="<%=ctx%>/cart/list">购物车</a>
                <a href="<%=ctx%>/order/list">我的订单</a>
            </div>
        </div>
    </div>
    <div class="container">
        <h2>购物车</h2>
        <c:if test="${empty cartList}">
            <div class="cart-empty">
                <p>购物车为空</p>
                <a href="<%=ctx%>/product/list" style="color: #4CAF50;">去购物</a>
            </div>
        </c:if>
        <c:if test="${not empty cartList}">
            <table class="cart-table">
                <tr>
                    <th>商品</th>
                    <th>书名</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>操作</th>
                </tr>
                <c:forEach var="cart" items="${cartList}">
                    <c:if test="${not empty cart and not empty cart.book}">
                        <tr>
                            <td><img src="<c:choose><c:when test="${not empty cart.book.image}">${cart.book.image}</c:when><c:otherwise><%=ctx%>/static/images/no-image.png</c:otherwise></c:choose>" onerror="this.onerror=null;this.src='<%=ctx%>/static/images/no-image.png';"></td>
                            <td>${cart.book.name}</td>
                            <td class="price">¥${cart.book.price}</td>
                            <td>
                                <div class="quantity-control">
                                    <button onclick="updateQuantity(${cart.bookId}, ${cart.quantity - 1})">-</button>
                                    <input type="text" value="${cart.quantity}" readonly style="width:40px;text-align:center;">
                                    <button onclick="updateQuantity(${cart.bookId}, ${cart.quantity + 1})">+</button>
                                </div>
                            </td>
                            <td class="price">¥<fmt:formatNumber value="${cart.book.price * cart.quantity}" pattern="#.##"/></td>
                            <td><button class="btn btn-delete" onclick="removeFromCart(${cart.bookId})">删除</button></td>
                        </tr>
                    </c:if>
                </c:forEach>
            </table>
            <div style="margin-top:20px;">
                <button class="btn btn-clear" onclick="clearCart()">清空购物车</button>
                <button class="btn btn-checkout" onclick="checkout()">结算</button>
            </div>
        </c:if>
    </div>
    <script>
        var contextPath = '<%=ctx%>';
        
        function updateQuantity(bookId, quantity) {
            if (quantity <= 0) {
                if (!confirm('确定移除此商品？')) return;
            }
            fetch(contextPath + '/cart/update', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'bookId=' + bookId + '&quantity=' + quantity
            }).then(function(res) { return res.json(); }).then(function(data) {
                if (data.code === 200) {
                    location.reload();
                } else {
                    alert(data.message);
                }
            });
        }
        function removeFromCart(bookId) {
            if (!confirm('确定删除此商品？')) return;
            fetch(contextPath + '/cart/remove', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'bookId=' + bookId
            }).then(function(res) { return res.json(); }).then(function(data) {
                if (data.code === 200) {
                    location.reload();
                } else {
                    alert(data.message);
                }
            });
        }
        function clearCart() {
            if (confirm('确定清空购物车？')) {
                fetch(contextPath + '/cart/clear', {method: 'POST'}).then(function(res) { return res.json(); }).then(function(data) {
                    if (data.code === 200) {
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                });
            }
        }
        function checkout() {
            location.href = contextPath + '/cart/checkout';
        }
    </script>
</body>
</html>