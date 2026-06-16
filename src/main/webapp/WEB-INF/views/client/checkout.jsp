<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%
    String ctx = request.getContextPath();
    if (ctx.equals("/") || ctx.equals("")) {
        ctx = "";
    }
    // 计算购物车总金额（避免EL表达式兼容性问题）
    java.util.List<com.mizore.entity.Cart> list = (java.util.List<com.mizore.entity.Cart>) request.getAttribute("cartList");
    java.math.BigDecimal total = java.math.BigDecimal.ZERO;
    if (list != null) {
        for (com.mizore.entity.Cart c : list) {
            if (c != null && c.getBook() != null && c.getBook().getPrice() != null && c.getQuantity() != null) {
                total = total.add(c.getBook().getPrice().multiply(java.math.BigDecimal.valueOf(c.getQuantity())));
            }
        }
    }
    request.setAttribute("cartTotal", total);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>结算</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f5f5f5; }
        .header { background-color: #4CAF50; padding: 15px; color: white; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 24px; font-weight: bold; }
        .nav a { color: white; margin-left: 20px; text-decoration: none; }
        .container { max-width: 800px; margin: 30px auto; }
        h2 { color: #333; margin-bottom: 20px; }
        .form-box { background: white; padding: 30px; margin-bottom: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        textarea { height: 80px; }
        .cart-box { background: white; padding: 20px; margin-bottom: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .cart-item { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #ddd; }
        .price { color: #f44336; font-weight: bold; }
        .btn-submit { background-color: #4CAF50; color: white; padding: 12px 30px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; width: 100%; }
        .btn-submit:hover { opacity: 0.8; }
        .total-row { display: flex; justify-content: space-between; font-weight: bold; padding-top: 15px; }
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
        <h2>确认订单</h2>
        <div class="form-box">
            <h3>收货信息</h3>
            <form id="checkoutForm">
                <div class="form-group">
                    <label>收货人：</label>
                    <input type="text" name="receiverName" placeholder="请输入收货人姓名" required>
                </div>
                <div class="form-group">
                    <label>联系电话：</label>
                    <input type="text" name="receiverPhone" placeholder="请输入联系电话" required>
                </div>
                <div class="form-group">
                    <label>收货地址：</label>
                    <textarea name="address" placeholder="请输入详细地址" required></textarea>
                </div>
            </form>
        </div>
        <div class="cart-box">
            <h3>商品清单</h3>
            <c:forEach var="cart" items="${cartList}">
                <c:if test="${not empty cart and not empty cart.book}">
                    <div class="cart-item">
                        <span>${cart.book.name} x ${cart.quantity}</span>
                        <span class="price">¥<fmt:formatNumber value="${cart.book.price * cart.quantity}" pattern="#.##"/></span>
                    </div>
                </c:if>
            </c:forEach>
            <div class="total-row">
                <span>合计：</span>
                <span class="price">¥<fmt:formatNumber value="${cartTotal}" pattern="#.##"/></span>
            </div>
        </div>
        <button class="btn-submit" onclick="submitOrder()">提交订单</button>
    </div>
    <script>
        var contextPath = '<%=ctx%>';
        function submitOrder() {
            var formData = new FormData(document.getElementById('checkoutForm'));
            fetch(contextPath + '/order/submit', {
                method: 'POST',
                body: new URLSearchParams(formData)
            }).then(function(res) { return res.json(); }).then(function(data) {
                alert(data.message);
                if (data.code === 200) {
                    location.href = contextPath + '/order/list';
                }
            });
        }
    </script>
</body>
</html>