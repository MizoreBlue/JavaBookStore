<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>我的订单</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #f5f5f5; }
        .header { background: #337ab7; color: white; padding: 15px 40px; }
        .header h1 { font-size: 20px; }
        .container { max-width: 1000px; margin: 30px auto; padding: 0 20px; }
        .order-card { background: white; border-radius: 8px; margin-bottom: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); overflow: hidden; }
        .order-header { background: #f8f9fa; padding: 12px 20px; display: flex; justify-content: space-between; color: #666; font-size: 13px; }
        .order-body { padding: 20px; }
        .order-total { color: #e4393c; font-size: 18px; font-weight: bold; }
        .order-status { padding: 3px 8px; background: #5cb85c; color: white; border-radius: 4px; font-size: 12px; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 8px; text-align: left; border-bottom: 1px solid #eee; }
        th { color: #666; font-size: 13px; font-weight: normal; }
        .empty { text-align: center; padding: 60px; color: #999; background: white; border-radius: 8px; }
        .info { color: #666; font-size: 13px; line-height: 1.8; }
    </style>
</head>
<body>
    <div class="header"><h1>我的订单</h1></div>
    <div class="container">
        <c:choose>
            <c:when test="${empty orderVos}">
                <div class="empty">暂无订单记录</div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${orderVos}" var="vo">
                    <div class="order-card">
                        <div class="order-header">
                            <span>订单号: ${vo.orders.id}</span>
                            <span>下单时间: ${vo.orders.createTime}</span>
                            <c:choose>
                                <c:when test="${vo.orders.status eq 4}">
                                    <span class="order-status" style="background:#5cb85c;">已完成</span>
                                </c:when>
                                <c:when test="${vo.orders.status eq 2}">
                                    <span class="order-status" style="background:#f0ad4e;">处理中</span>
                                </c:when>
                                <c:when test="${vo.orders.status eq 3}">
                                    <span class="order-status" style="background:#5bc0de;">已发货</span>
                                </c:when>
                                <c:when test="${vo.orders.status eq 0}">
                                    <span class="order-status" style="background:#777;">已取消</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="order-status" style="background:#f0ad4e;">待支付</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="order-body">
                            <div class="info">
                                收货人: ${vo.orders.receiverName} | 电话: ${vo.orders.receiverPhone}<br>
                                地址: ${vo.orders.address}
                            </div>
                            <table>
                                <tr><th>图书</th><th>数量</th><th>金额</th></tr>
                                <c:forEach items="${vo.orderDetailList}" var="d">
                                    <tr><td>${d.bookName}</td><td>${d.number}</td><td style="color:#e4393c;">¥ ${d.amount}</td></tr>
                                </c:forEach>
                            </table>
                            <div style="text-align:right;margin-top:15px;" class="order-total">订单总额: ¥ ${vo.orders.totalAmount}</div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
