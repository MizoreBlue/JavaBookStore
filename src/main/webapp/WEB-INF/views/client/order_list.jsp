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
    <title>我的订单</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f5f5f5; }
        .header { background-color: #4CAF50; padding: 15px; color: white; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 24px; font-weight: bold; }
        .nav a { color: white; margin-left: 20px; text-decoration: none; }
        .container { max-width: 1000px; margin: 30px auto; }
        h2 { color: #333; margin-bottom: 20px; }
        .order-empty { background: white; padding: 50px; text-align: center; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .order-card { background: white; padding: 20px; margin-bottom: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .order-header { display: flex; justify-content: space-between; margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid #ddd; }
        .order-id { font-weight: bold; }
        .order-status { color: #4CAF50; }
        .btn { padding: 8px 16px; border: none; cursor: pointer; border-radius: 4px; text-decoration: none; }
        .btn-detail { background-color: #2196F3; color: white; }
        .btn-cancel { background-color: #f44336; color: white; }
        .btn:hover { opacity: 0.8; }
        .price { color: #f44336; font-weight: bold; }
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
        <h2>我的订单</h2>
        <c:if test="${empty orders}">
            <div class="order-empty">
                <p>暂无订单</p>
                <a href="<%=ctx%>/product/list" style="color: #4CAF50;">去购物</a>
            </div>
        </c:if>
        <c:if test="${not empty orders}">
            <c:forEach var="order" items="${orders}">
                <div class="order-card">
                    <div class="order-header">
                        <div class="order-id">订单号：${order.id}</div>
                        <div class="order-status">
                            <c:choose>
                                <c:when test="${order.status == 0}">已取消</c:when>
                                <c:when test="${order.status == 1}">待支付</c:when>
                                <c:when test="${order.status == 2}">已支付</c:when>
                                <c:when test="${order.status == 3}">已发货</c:when>
                                <c:when test="${order.status == 4}">已完成</c:when>
                            </c:choose>
                        </div>
                    </div>
                    <div>收货人：${order.receiverName} ${order.receiverPhone}</div>
                    <div>收货地址：${order.address}</div>
                    <div>订单金额：<span class="price">¥${order.totalAmount}</span></div>
                    <div>创建时间：${order.createTime}</div>
                    <div style="margin-top: 15px;">
                        <a href="<%=ctx%>/order/detail?id=${order.id}" class="btn btn-detail">查看详情</a>
                        <c:if test="${order.status == 1}">
                            <button class="btn btn-cancel" onclick="cancelOrder(${order.id})">取消订单</button>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>
    <script>
        var contextPath = '<%=ctx%>';
        function cancelOrder(orderId) {
            if (confirm('确定取消订单吗？')) {
                fetch(contextPath + '/order/cancel', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'orderId=' + orderId
                }).then(function(res) { return res.json(); }).then(function(data) {
                    alert(data.message);
                    location.reload();
                });
            }
        }
    </script>
</body>
</html>