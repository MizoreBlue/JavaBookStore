<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户登录</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #337ab7; display: flex; align-items: center; justify-content: center; min-height: 100vh; }
        .login-box { background: white; padding: 40px; border-radius: 10px; width: 400px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); }
        h1 { text-align: center; color: #337ab7; margin-bottom: 30px; font-size: 24px; }
        form div { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #555; font-size: 14px; }
        input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; }
        button { width: 100%; padding: 12px; background: #337ab7; color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; margin-top: 10px; }
        button:hover { background: #286090; }
        .error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 14px; }
        .success { background: #d4edda; color: #155724; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 14px; }
        .link { text-align: center; margin-top: 15px; font-size: 14px; }
        .link a { color: #337ab7; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-box">
        <h1>用户登录</h1>
        <c:if test="${not empty message}">
            <div class="${message.contains('成功') ? 'success' : 'error'}">${message}</div>
        </c:if>
        <c:if test="${not empty sessionScope.loginMessage}">
            <div class="error">${sessionScope.loginMessage}</div>
            <c:remove var="loginMessage" scope="session" />
        </c:if>
        <form action="${pageContext.request.contextPath}/user" method="post">
            <input type="hidden" name="action" value="doLogin">
            <div><label>用户名</label><input type="text" name="username" required></div>
            <div><label>密码</label><input type="password" name="password" required></div>
            <button type="submit">登录</button>
        </form>
        <div class="link">
            <a href="${pageContext.request.contextPath}/">返回首页</a> | 
            <a href="${pageContext.request.contextPath}/user?action=register">注册账号</a> |
            <a href="${pageContext.request.contextPath}/backend/login">后台登录</a>
        </div>
    </div>
</body>
</html>
