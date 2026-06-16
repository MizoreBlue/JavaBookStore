<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
    <title>订单详情</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f5f5f5; }
        .header { background-color: #4CAF50; padding: 15px; color: white; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 24px; font-weight: bold; }
        .nav a { color: white; margin-left: 20px; text-decoration: none; }
        .container { max-width: 800px; margin: 30px auto; }
        h2 { color: #333; margin-bottom: 20px; }
        .info-box { background: white; padding: 20px; margin-bottom: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .info-row { margin-bottom: 10px; }
        .info-label { display: inline-block; width: 120px; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f8f8f8; }
        .price { color: #f44336; font-weight: bold; }
        .btn-back { padding: 10px 20px; background-color: #f1f1f1; color: #333; text-decoration: none; border-radius: 4px; }
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
        <h2>订单详情</h2>
        <c:choose>
            <c:when test="${not empty order}">
                <div class="info-box">
                    <div class="info-row"><span class="info-label">订单号：</span>${order.id}</div>
                    <div class="info-row"><span class="info-label">收货人：</span>${order.receiverName} ${order.receiverPhone}</div>
                    <div class="info-row"><span class="info-label">收货地址：</span>${order.address}</div>
                    <div class="info-row"><span class="info-label">订单金额：</span><span class="price">¥${order.totalAmount}</span></div>
                    <div class="info-row"><span class="info-label">订单状态：</span>
                        <c:choose>
                            <c:when test="${order.status == 0}">已取消</c:when>
                            <c:when test="${order.status == 1}">待支付</c:when>
                            <c:when test="${order.status == 2}">已支付</c:when>
                            <c:when test="${order.status == 3}">已发货</c:when>
                            <c:when test="${order.status == 4}">已完成</c:when>
                        </c:choose>
                    </div>
                    <div class="info-row"><span class="info-label">创建时间：</span>${order.createTime}</div>
                </div>
                <table>
                    <tr>
                        <th>商品名称</th>
                        <th>数量</th>
                        <th>单价</th>
                        <th>小计</th>
                    </tr>
                    <c:forEach var="detail" items="${details}">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty detail.book}">${detail.book.name}</c:when>
                                    <c:otherwise>商品已下架</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${detail.number}</td>
                            <td class="price">¥<c:if test="${not empty detail.number and detail.number > 0}"><fmt:formatNumber value="${detail.amount / detail.number}" pattern="#.##"/></c:if></td>
                            <td class="price">¥${detail.amount}</td>
                        </tr>
                    </c:forEach>
                </table>
                <br><a href="<%=ctx%>/order/list" class="btn-back">返回订单列表</a>
            </c:when>
            <c:otherwise>
                <div class="info-box" style="text-align:center;">
                    <h3 style="color:#f44336;">订单不存在或您无权限查看</h3>
                    <a href="<%=ctx%>/order/list" class="btn-back" style="display:inline-block;margin-top:20px;">返回订单列表</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>