<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>后台登录</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #2c3e50; display: flex; align-items: center; justify-content: center; min-height: 100vh; }
        .login-box { background: white; padding: 40px; border-radius: 10px; width: 400px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); }
        h1 { text-align: center; color: #2c3e50; margin-bottom: 30px; font-size: 24px; }
        form div { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #555; font-size: 14px; }
        input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; }
        button { width: 100%; padding: 12px; background: #2c3e50; color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; margin-top: 10px; }
        button:hover { background: #1a252f; }
        .error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 14px; }
        .link { text-align: center; margin-top: 15px; font-size: 14px; }
        .link a { color: #2c3e50; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-box">
        <h1>后台管理登录</h1>
        <c:if test="${not empty message}"><div class="error">${message}</div></c:if>
        <form action="${pageContext.request.contextPath}/backend/login" method="post">
            <div><label>用户名</label><input type="text" name="username" required></div>
            <div><label>密码</label><input type="password" name="password" required></div>
            <button type="submit">登录</button>
        </form>
        <div class="link"><a href="${pageContext.request.contextPath}/">返回前台</a></div>
    </div>
</body>
</html>
