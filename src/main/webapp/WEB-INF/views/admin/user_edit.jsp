<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>编辑用户</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #ecf0f1; }
        .layout { display: flex; min-height: 100vh; }
        .sidebar { width: 220px; background: #2c3e50; color: white; padding: 20px 0; flex-shrink: 0; }
        .sidebar h2 { padding: 0 20px 20px; font-size: 18px; border-bottom: 1px solid #34495e; }
        .sidebar a { display: block; padding: 12px 25px; color: #bdc3c7; text-decoration: none; font-size: 14px; }
        .sidebar a:hover, .sidebar a.active { background: #34495e; color: white; border-left: 4px solid #3498db; }
        .main { flex: 1; padding: 20px; display: flex; flex-direction: column; align-items: center; }
        .topbar { background: white; padding: 12px 20px; border-radius: 6px; margin-bottom: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); width: 100%; max-width: 700px; text-align: center; }
        .topbar h1 { font-size: 18px; color: #2c3e50; }
        .card { background: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); width: 100%; max-width: 700px; }
        .card h2 { font-size: 16px; color: #2c3e50; margin-bottom: 20px; border-left: 4px solid #3498db; padding-left: 10px; }
        form .form-row { margin-bottom: 18px; }
        label { display: block; margin-bottom: 6px; color: #555; font-size: 14px; font-weight: 500; }
        input[type="text"], input[type="email"], select {
            width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px;
        }
        input[readonly] { background: #f5f5f5; color: #999; }
        .btn-group { display: flex; justify-content: center; gap: 15px; margin-top: 25px; }
        .btn { padding: 10px 30px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 14px; display: inline-block; color: white; }
        .btn-primary { background: #3498db; }
        .btn-default { background: #95a5a6; }
        .btn-warning { background: #f39c12; }
        .error-msg { color: #e74c3c; font-size: 13px; margin-bottom: 10px; }
        @media (max-width: 768px) {
            .layout { flex-direction: column; }
            .sidebar { width: 100%; display: flex; flex-wrap: wrap; padding: 10px 0; }
            .sidebar h2 { width: 100%; padding: 0 15px 10px; }
            .sidebar a { padding: 8px 15px; font-size: 13px; }
            .main { padding: 15px; }
            .card { padding: 20px; }
            .btn-group { flex-direction: column; }
            .btn { width: 100%; text-align: center; }
        }
    </style>
</head>
<body>
    <div class="layout">
        <div class="sidebar">
            <h2>Java Book Store</h2>
            <a href="${pageContext.request.contextPath}/backend/home">控制台</a>
            <a href="${pageContext.request.contextPath}/backend/book">图书管理</a>
            <a href="${pageContext.request.contextPath}/backend/category">分类管理</a>
            <a href="${pageContext.request.contextPath}/backend/order">订单管理</a>
            <a href="${pageContext.request.contextPath}/backend/user" class="active">用户管理</a>
        </div>
        <div class="main">
            <div class="topbar"><h1>编辑用户</h1></div>
            <div class="card">
                <h2>用户资料</h2>
                <form action="${pageContext.request.contextPath}/backend/user" method="post">
                    <input type="hidden" name="action" value="save">
                    <input type="hidden" name="id" value="${user.id}">
                    <div class="form-row">
                        <label>用户名</label>
                        <input type="text" value="${user.username}" readonly>
                    </div>
                    <div class="form-row">
                        <label>手机号</label>
                        <input type="text" name="phone" value="${user.phone}">
                    </div>
                    <div class="form-row">
                        <label>邮箱</label>
                        <input type="email" name="email" value="${user.email}">
                    </div>
                    <div class="form-row">
                        <label>性别</label>
                        <select name="sex">
                            <option value="">未知</option>
                            <option value="M" ${user.sex == 'M' ? 'selected' : ''}>男</option>
                            <option value="F" ${user.sex == 'F' ? 'selected' : ''}>女</option>
                        </select>
                    </div>
                    <div class="form-row">
                        <label>头像URL</label>
                        <input type="text" name="avatar" value="${user.avatar}">
                    </div>
                    <div class="form-row">
                        <label>账号状态</label>
                        <select name="status">
                            <option value="1" ${user.status == 1 ? 'selected' : ''}>正常</option>
                            <option value="0" ${user.status == 0 ? 'selected' : ''}>禁用</option>
                        </select>
                    </div>
                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">保存修改</button>
                        <a href="${pageContext.request.contextPath}/backend/user" class="btn btn-default">返回</a>
                    </div>
                </form>

                <h2 style="margin-top:30px; border-left-color:#e74c3c;">修改密码</h2>
                <c:if test="${not empty error}">
                    <div class="error-msg">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/backend/user" method="post">
                    <input type="hidden" name="action" value="changePassword">
                    <input type="hidden" name="id" value="${user.id}">
                    <div class="form-row">
                        <label>新密码</label>
                        <input type="password" name="newPassword" placeholder="请输入6-20位新密码">
                    </div>
                    <div class="form-row">
                        <label>确认密码</label>
                        <input type="password" name="confirmPassword" placeholder="请再次输入新密码">
                    </div>
                    <div class="btn-group">
                        <button type="submit" class="btn btn-warning">修改密码</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
