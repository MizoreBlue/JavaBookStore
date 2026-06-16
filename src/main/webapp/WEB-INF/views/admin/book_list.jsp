<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>图书管理</title>
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
        .topbar .user-info { color: #666; font-size: 14px; }
        .topbar a { color: #e74c3c; text-decoration: none; margin-left: 15px; }
        .card { background: white; border-radius: 8px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .card h2 { font-size: 16px; color: #2c3e50; margin-bottom: 15px; }
        .search-row { margin-bottom: 15px; display: flex; gap: 10px; }
        .search-row input { flex: 1; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .search-row button { padding: 8px 16px; background: #3498db; color: white; border: none; border-radius: 4px; cursor: pointer; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #34495e; color: white; padding: 10px; text-align: left; font-size: 13px; }
        td { padding: 10px; border-bottom: 1px solid #eee; font-size: 13px; }
        tr:hover { background: #f9f9f9; }
        .btn { padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 12px; display: inline-block; color: white; }
        .btn-primary { background: #3498db; }
        .btn-success { background: #27ae60; }
        .btn-danger { background: #e74c3c; }
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
            <a href="${pageContext.request.contextPath}/backend/book" class="active">图书管理</a>
            <a href="${pageContext.request.contextPath}/backend/category">分类管理</a>
            <a href="${pageContext.request.contextPath}/backend/order">订单管理</a>
            <a href="${pageContext.request.contextPath}/backend/user">用户管理</a>
        </div>
        <div class="main">
            <div class="topbar">
                <h1>图书管理</h1>
                <div class="user-info">
                    欢迎, ${employee.username}
                    <a href="${pageContext.request.contextPath}/backend/book?action=logout">退出登录</a>
                </div>
            </div>

            <div class="card">
                <div class="search-row">
                    <form action="${pageContext.request.contextPath}/backend/book" method="get" style="display:flex;gap:10px;flex:1;">
                        <input type="text" name="keyword" placeholder="请输入图书名称" value="${keyword}">
                        <button type="submit">搜索</button>
                    </form>
                    <a href="${pageContext.request.contextPath}/backend/book?action=add" class="btn btn-success">+ 新增图书</a>
                </div>
                <table>
                    <tr><th>ID</th><th>书名</th><th>作者</th><th>分类</th><th>价格</th><th>库存</th><th>操作</th></tr>
                    <c:if test="${empty pageResult.records}">
                        <tr><td colspan="7" style="text-align:center;color:#999;">暂无数据</td></tr>
                    </c:if>
                    <c:forEach items="${pageResult.records}" var="book">
                        <tr>
                            <td>${book.id}</td>
                            <td>${book.name}</td>
                            <td>${book.author}</td>
                            <td>${book.category}</td>
                            <td style="color:#e74c3c;">¥ ${book.price}</td>
                            <td>${book.stock}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/backend/book?action=edit&id=${book.id}" class="btn btn-primary">编辑</a>
                                <a href="${pageContext.request.contextPath}/backend/book?action=delete&id=${book.id}" class="btn btn-danger" onclick="return confirm('确认删除?')">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <div class="pagination">
                    <c:if test="${pageResult.pageNum > 1}">
                        <a href="${pageContext.request.contextPath}/backend/book?page=${pageResult.pageNum - 1}&keyword=${keyword}">上一页</a>
                    </c:if>
                    <span class="current">${pageResult.pageNum} / ${pageResult.pages}</span>
                    <c:if test="${pageResult.pageNum < pageResult.pages}">
                        <a href="${pageContext.request.contextPath}/backend/book?page=${pageResult.pageNum + 1}&keyword=${keyword}">下一页</a>
                    </c:if>
                    <span>共 ${pageResult.total} 条</span>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
