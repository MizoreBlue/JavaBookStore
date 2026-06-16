<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>订单管理</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #ecf0f1; }
        .layout { display: flex; min-height: 100vh; }
        .sidebar { width: 220px; background: #2c3e50; color: white; padding: 20px 0; }
        .sidebar h2 { padding: 0 20px 20px; font-size: 18px; border-bottom: 1px solid #34495e; }
        .sidebar a { display: block; padding: 12px 25px; color: #bdc3c7; text-decoration: none; font-size: 14px; }
        .sidebar a:hover, .sidebar a.active { background: #34495e; color: white; border-left: 4px solid #3498db; }
        .main { flex: 1; padding: 20px; }
        .topbar { background: white; padding: 12px 20px; border-radius: 6px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .topbar h1 { font-size: 18px; color: #2c3e50; }
        .topbar a { color: #e74c3c; text-decoration: none; margin-left: 15px; }
        .card { background: white; border-radius: 8px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .order-item { border: 1px solid #eee; border-radius: 6px; margin-bottom: 15px; padding: 15px; }
        .order-head { display: flex; justify-content: space-between; padding-bottom: 10px; border-bottom: 1px dashed #eee; margin-bottom: 10px; font-size: 13px; color: #666; }
        .order-body { display: flex; justify-content: space-between; align-items: flex-start; }
        .book-list { flex: 2; }
        .book-row { display: flex; justify-content: space-between; padding: 4px 0; font-size: 13px; }
        .order-actions { text-align: right; }
        .order-amount { font-size: 20px; color: #e74c3c; font-weight: bold; margin: 10px 0; }
        .btn { padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 12px; display: inline-block; color: white; }
        .btn-success { background: #27ae60; }
        .btn-warning { background: #f39c12; }
        .btn-danger { background: #e74c3c; }
        .status-badge { display: inline-block; padding: 3px 8px; border-radius: 4px; font-size: 12px; color: white; }
        .status-done { background: #27ae60; }
        .status-pending { background: #f39c12; }
        .pagination { text-align: center; margin-top: 20px; }
        .pagination a, .pagination span { display: inline-block; padding: 6px 12px; margin: 0 2px; background: white; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #333; font-size: 13px; }
        .pagination .current { background: #3498db; color: white; border-color: #3498db; }
    </style>
</head>
<body>
    <div class="layout">
        <div class="sidebar">
            <h2>Java Book Store</h2>
            <a href="${pageContext.request.contextPath}/backend/home">控制台</a>
            <a href="${pageContext.request.contextPath}/backend/book">图书管理</a>
            <a href="${pageContext.request.contextPath}/backend/category">分类管理</a>
            <a href="${pageContext.request.contextPath}/backend/order" class="active">订单管理</a>
            <a href="${pageContext.request.contextPath}/backend/user">用户管理</a>
        </div>
        <div class="main">
            <div class="topbar">
                <h1>订单管理</h1>
                <div>欢迎, ${employee.username} <a href="${pageContext.request.contextPath}/backend/book?action=logout">退出</a></div>
            </div>

            <div class="card">
                <c:if test="${empty orderVos}">
                    <div style="text-align:center;padding:40px;color:#999;">暂无订单</div>
                </c:if>
                <c:forEach items="${orderVos}" var="vo">
                    <div class="order-item">
                        <div class="order-head">
                            <span>订单号: <strong>#${vo.orders.id}</strong></span>
                            <span>用户: ${vo.user.username}</span>
                            <span>电话: ${vo.orders.receiverPhone}</span>
                            <span>时间: ${vo.orders.createTime}</span>
                            <c:choose>
                                <c:when test="${vo.orders.status eq 4}">
                                    <span class="status-badge status-done">已完成</span>
                                </c:when>
                                <c:when test="${vo.orders.status eq 2}">
                                    <span class="status-badge status-pending">处理中</span>
                                </c:when>
                                <c:when test="${vo.orders.status eq 3}">
                                    <span class="status-badge status-done">已发货</span>
                                </c:when>
                                <c:when test="${vo.orders.status eq 0}">
                                    <span class="status-badge" style="background:#95a5a6;">已取消</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-pending">待支付</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="order-body">
                            <div class="book-list">
                                <c:forEach items="${vo.orderDetailList}" var="d">
                                    <div class="book-row">
                                        <span>${d.bookName} x ${d.number}</span>
                                        <span style="color:#e74c3c;">¥ ${d.amount}</span>
                                    </div>
                                </c:forEach>
                                <div style="margin-top:8px;font-size:13px;color:#666;">
                                    收货: ${vo.orders.receiverName} | 地址: ${vo.orders.address}
                                </div>
                            </div>
                            <div class="order-actions">
                                <div class="order-amount">¥ ${vo.orders.totalAmount}</div>
                                <c:if test="${vo.orders.status eq 2}">
                                    <a href="${pageContext.request.contextPath}/backend/order?action=status&id=${vo.orders.id}&status=4" class="btn btn-success" onclick="return confirm('确认发货?')">发货</a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/backend/order?action=delete&id=${vo.orders.id}" class="btn btn-danger" onclick="return confirm('确认删除?')">删除</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <div class="pagination">
                    <c:if test="${pageResult.pageNum > 1}">
                        <a href="${pageContext.request.contextPath}/backend/order?page=${pageResult.pageNum - 1}">上一页</a>
                    </c:if>
                    <span class="current">${pageResult.pageNum} / ${pageResult.pages}</span>
                    <c:if test="${pageResult.pageNum < pageResult.pages}">
                        <a href="${pageContext.request.contextPath}/backend/order?page=${pageResult.pageNum + 1}">下一页</a>
                    </c:if>
                    <span>共 ${pageResult.total} 条</span>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
