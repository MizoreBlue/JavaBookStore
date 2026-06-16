<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    if (ctx.equals("/") || ctx.equals("")) { ctx = ""; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理 - 登录</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); height: 100vh; display: flex; align-items: center; justify-content: center; }
        .login-box { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 380px; }
        .login-box h2 { text-align: center; margin-bottom: 30px; color: #333; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 6px; color: #555; font-size: 14px; }
        .form-group input { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px; font-size: 14px; transition: border-color 0.3s; }
        .form-group input:focus { border-color: #667eea; outline: none; }
        .btn-login { width: 100%; padding: 12px; background: linear-gradient(135deg, #667eea, #764ba2); color: white; border: none; border-radius: 6px; font-size: 16px; cursor: pointer; }
        .btn-login:hover { opacity: 0.9; }
        .btn-login:disabled { opacity: 0.6; cursor: not-allowed; }
        .error-msg { color: #f44336; text-align: center; margin-top: 10px; font-size: 14px; display: none; }
        .back-link { display: block; text-align: center; margin-top: 15px; color: #999; font-size: 13px; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>图书商城 · 后台管理</h2>
        <form id="loginForm" onsubmit="return doLogin()">
            <div class="form-group">
                <label>用户名</label>
                <input type="text" id="username" placeholder="请输入管理员用户名" required>
            </div>
            <div class="form-group">
                <label>密码</label>
                <input type="password" id="password" placeholder="请输入密码" required>
            </div>
            <button type="submit" class="btn-login" id="loginBtn">登 录</button>
            <div class="error-msg" id="errorMsg"></div>
        </form>
        <a href="<%=ctx%>/" class="back-link">返回前台首页</a>
    </div>
    <script>
        function doLogin() {
            var username = document.getElementById('username').value.trim();
            var password = document.getElementById('password').value;
            var btn = document.getElementById('loginBtn');
            var errorMsg = document.getElementById('errorMsg');

            if (!username || !password) {
                errorMsg.textContent = '请输入用户名和密码';
                errorMsg.style.display = 'block';
                return false;
            }

            btn.disabled = true;
            btn.textContent = '登录中...';
            errorMsg.style.display = 'none';

            fetch('<%=ctx%>/backend/login/login', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'username=' + encodeURIComponent(username) + '&password=' + encodeURIComponent(password)
            })
            .then(function(res) { return res.json(); })
            .then(function(data) {
                if (data.code === 200) {
                    window.location.href = data.data || '<%=ctx%>/backend/home';
                } else {
                    errorMsg.textContent = data.message;
                    errorMsg.style.display = 'block';
                    btn.disabled = false;
                    btn.textContent = '登 录';
                }
            })
            .catch(function() {
                errorMsg.textContent = '网络错误，请重试';
                errorMsg.style.display = 'block';
                btn.disabled = false;
                btn.textContent = '登 录';
            });
            return false;
        }
    </script>
</body>
</html>