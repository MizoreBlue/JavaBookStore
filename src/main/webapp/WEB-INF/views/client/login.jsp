<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>用户登录 - 图书商城</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f5f5f5; }
        .header { background-color: #4CAF50; padding: 15px; color: white; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 24px; font-weight: bold; }
        .nav a { color: white; margin-left: 20px; text-decoration: none; }
        .container { max-width: 400px; margin: 80px auto; }
        h2 { color: #333; margin-bottom: 20px; text-align: center; }
        .form-box { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
        input { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        input:focus { outline: none; border-color: #4CAF50; }
        input.error { border-color: #f44336; }
        .error-msg { color: #f44336; font-size: 12px; margin-top: 5px; display: none; }
        .btn { padding: 12px; border: none; cursor: pointer; border-radius: 4px; width: 100%; font-size: 16px; }
        .btn-submit { background-color: #4CAF50; color: white; margin-top: 10px; }
        .btn-submit:hover { background-color: #45a049; }
        .btn-secondary { background-color: #666; color: white; margin-top: 10px; }
        .btn-secondary:hover { background-color: #555; }
        .message { padding: 15px; border-radius: 4px; margin-bottom: 15px; text-align: center; }
        .message.success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .message.error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .links { display: flex; justify-content: space-between; margin-top: 15px; font-size: 14px; }
        .links a { color: #4CAF50; text-decoration: none; }
        .links a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo"><a href="<%=ctx%>/" style="color: white; text-decoration: none;">图书商城</a></div>
            <div class="nav">
                <a href="<%=ctx%>/">首页</a>
                <a href="<%=ctx%>/user/register">注册</a>
            </div>
        </div>
    </div>

    <div class="container">
        <h2>用户登录</h2>
        <div class="form-box">
            <div id="messageBox" class="message" style="display: none;"></div>
            
            <form id="loginForm" onsubmit="return handleLogin(event)">
                <div class="form-group">
                    <label>用户名 <span style="color: #f44336;">*</span></label>
                    <input type="text" id="username" name="username" placeholder="请输入用户名" required>
                    <div id="usernameError" class="error-msg">请输入用户名</div>
                </div>
                
                <div class="form-group">
                    <label>密码 <span style="color: #f44336;">*</span></label>
                    <input type="password" id="password" name="password" placeholder="请输入密码" required>
                    <div id="passwordError" class="error-msg">请输入密码</div>
                </div>
                
                <button type="submit" class="btn btn-submit" id="submitBtn">登录</button>
                <button type="button" class="btn btn-secondary" onclick="window.location.href='<%=ctx%>/'">返回首页</button>
            </form>
            
            <div class="links">
                <a href="<%=ctx%>/user/register">还没有账号？立即注册</a>
                <a href="<%=ctx%>/">返回首页</a>
            </div>
        </div>
    </div>

    <script>
        var contextPath = '<%=ctx%>';
        
        function showMessage(type, text) {
            var messageBox = document.getElementById('messageBox');
            messageBox.className = 'message ' + type;
            messageBox.textContent = text;
            messageBox.style.display = 'block';
        }

        function handleLogin(event) {
            event.preventDefault();
            
            var username = document.getElementById('username').value.trim();
            var password = document.getElementById('password').value;
            
            if (!username) {
                showMessage('error', '请输入用户名');
                return false;
            }
            if (!password) {
                showMessage('error', '请输入密码');
                return false;
            }
            
            var submitBtn = document.getElementById('submitBtn');
            submitBtn.disabled = true;
            submitBtn.textContent = '登录中...';
            
            var formData = new URLSearchParams();
            formData.append('username', username);
            formData.append('password', password);
            
            fetch(contextPath + '/user/login', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: formData.toString()
            })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.code === 200) {
                    showMessage('success', '登录成功！正在跳转到首页...');
                    setTimeout(function() {
                        window.location.href = contextPath + '/';
                    }, 1000);
                } else {
                    showMessage('error', data.message || '登录失败，请检查用户名和密码');
                    submitBtn.disabled = false;
                    submitBtn.textContent = '登录';
                }
            })
            .catch(function(error) {
                showMessage('error', '登录失败：网络错误，请稍后重试');
                submitBtn.disabled = false;
                submitBtn.textContent = '登录';
            });
            
            return false;
        }
    </script>
</body>
</html>