<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>管理后台 - 首页</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #ecf0f1; }
        .layout { display: flex; min-height: 100vh; }
        .sidebar { width: 220px; background: #2c3e50; color: white; padding: 20px 0; }
        .sidebar h2 { padding: 0 20px 20px; font-size: 18px; border-bottom: 1px solid #34495e; }
        .sidebar a { display: block; padding: 12px 25px; color: #bdc3c7; text-decoration: none; font-size: 14px; }
        .sidebar a:hover, .sidebar a.active { background: #34495e; color: white; border-left: 4px solid #3498db; padding-left: 21px; }
        .main { flex: 1; padding: 20px; }
        .topbar { background: white; padding: 12px 20px; border-radius: 6px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .topbar h1 { font-size: 18px; color: #2c3e50; }
        .topbar .user-info { color: #666; font-size: 14px; }
        .topbar a { color: #e74c3c; text-decoration: none; margin-left: 15px; }
        .stats { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 20px; }
        .stat-card { background: white; padding: 25px; border-radius: 8px; text-align: center; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .stat-num { font-size: 32px; font-weight: bold; color: #3498db; margin-bottom: 5px; }
        .stat-label { color: #666; font-size: 14px; }
        .card { background: white; border-radius: 8px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .card h2 { font-size: 16px; color: #2c3e50; margin-bottom: 15px; border-left: 4px solid #3498db; padding-left: 10px; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #34495e; color: white; padding: 10px; text-align: left; font-size: 13px; }
        td { padding: 10px; border-bottom: 1px solid #eee; font-size: 13px; }
        tr:hover { background: #f9f9f9; }
        .rank-num { display: inline-block; width: 24px; height: 24px; line-height: 24px; text-align: center; background: #3498db; color: white; border-radius: 50%; font-size: 12px; margin-right: 8px; }
        .rank-num.top1 { background: #e74c3c; }
        .rank-num.top2 { background: #f39c12; }
        .rank-num.top3 { background: #f1c40f; }
    </style>
</head>
<body>
    <div class="layout">
        <div class="sidebar">
            <h2>Java Book Store</h2>
            <a href="${pageContext.request.contextPath}/backend/home" class="active">控制台</a>
            <a href="${pageContext.request.contextPath}/backend/book">图书管理</a>
            <a href="${pageContext.request.contextPath}/backend/category">分类管理</a>
            <a href="${pageContext.request.contextPath}/backend/order">订单管理</a>
            <a href="${pageContext.request.contextPath}/backend/user">用户管理</a>
        </div>
        <div class="main">
            <div class="topbar">
                <h1>欢迎, ${employee.username}</h1>
                <div class="user-info">
                    当前在线: ${onlineCount} 人
                    <a href="${pageContext.request.contextPath}/backend/book?action=logout">退出登录</a>
                </div>
            </div>

            <div class="stats">
                <div class="stat-card"><div class="stat-num">${totalUser}</div><div class="stat-label">注册用户</div></div>
                <div class="stat-card"><div class="stat-num">${totalBook}</div><div class="stat-label">图书总数</div></div>
                <div class="stat-card"><div class="stat-num">${totalOrder}</div><div class="stat-label">订单总数</div></div>
                <div class="stat-card"><div class="stat-num">${todayOrder}</div><div class="stat-label">今日订单</div></div>
            </div>

            <div class="card">
                <h2>销售排行榜</h2>
                <table>
                    <tr><th>排名</th><th>图书名称</th><th>作者</th><th>销量</th></tr>
                    <c:forEach items="${rank}" var="item" varStatus="status">
                        <tr>
                            <td><span class="rank-num ${status.index lt 3 ? 'top'.concat(status.index + 1) : ''}">${status.index + 1}</span></td>
                            <td>${item.bookName}</td>
                            <td>${item.author}</td>
                            <td style="color:#e74c3c;font-weight:bold;">${item.totalSales} 本</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <div class="card">
                <h2>最近订单</h2>
                <table>
                    <tr><th>订单号</th><th>用户</th><th>金额</th><th>状态</th><th>时间</th></tr>
                    <c:forEach items="${recentOrders}" var="vo">
                        <tr>
                            <td>${vo.orders.id}</td>
                            <td>${vo.user.username}</td>
                            <td style="color:#e74c3c;">¥ ${vo.orders.totalAmount}</td>
                            <td>${vo.orders.status eq 1 ? '已完成' : '处理中'}</td>
                            <td>${vo.orders.createTime}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <div class="card">
                <h2>运营数据</h2>
                <div style="color:#666;line-height:2;font-size:14px;">
                    总销售额: <span style="color:#e74c3c;font-weight:bold;font-size:18px;">¥ ${report.totalAmount}</span><br>
                    有效订单数: ${report.orderCount} 单<br>
                    销售图书总量: ${report.totalBookCount} 本
                </div>
            </div>
        </div>
    </div>
</body>
</html>
