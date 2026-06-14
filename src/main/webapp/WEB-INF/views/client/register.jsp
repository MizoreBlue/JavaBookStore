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
    <title>用户注册 - 图书商城</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f5f5f5; }
        .header { background-color: #4CAF50; padding: 15px; color: white; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 24px; font-weight: bold; }
        .nav a { color: white; margin-left: 20px; text-decoration: none; }
        .container { max-width: 500px; margin: 50px auto; }
        h2 { color: #333; margin-bottom: 20px; text-align: center; }
        .form-box { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        input:focus, select:focus { outline: none; border-color: #4CAF50; }
        input.error { border-color: #f44336; }
        .error-msg { color: #f44336; font-size: 12px; margin-top: 3px; display: none; }
        .btn { padding: 12px 20px; border: none; cursor: pointer; border-radius: 4px; width: 100%; font-size: 16px; }
        .btn-submit { background-color: #4CAF50; color: white; }
        .btn-submit:hover { background-color: #45a049; }
        .btn-secondary { background-color: #666; color: white; margin-top: 10px; }
        .btn-secondary:hover { background-color: #555; }
        .message { padding: 15px; border-radius: 4px; margin-bottom: 15px; text-align: center; }
        .message.success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .message.error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .login-link { text-align: center; margin-top: 15px; }
        .login-link a { color: #4CAF50; text-decoration: none; }
        .login-link a:hover { text-decoration: underline; }
        .password-strength { height: 5px; margin-top: 5px; background: #ddd; border-radius: 3px; }
        .password-strength div { height: 100%; border-radius: 3px; transition: width 0.3s; }
        .strength-weak { width: 33%; background: #f44336; }
        .strength-medium { width: 66%; background: #ff9800; }
        .strength-strong { width: 100%; background: #4CAF50; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo"><a href="<%=ctx%>/" style="color: white; text-decoration: none;">图书商城</a></div>
            <div class="nav">
                <a href="<%=ctx%>/">首页</a>
                <a href="<%=ctx%>/user/login">登录</a>
            </div>
        </div>
    </div>

    <div class="container">
        <h2>用户注册</h2>
        <div class="form-box">
            <div id="messageBox" class="message" style="display: none;"></div>
            
            <form id="registerForm" onsubmit="return handleRegister(event)">
                <div class="form-group">
                    <label>用户名 <span style="color: #f44336;">*</span></label>
                    <input type="text" id="username" name="username" placeholder="请输入用户名" required>
                    <div id="usernameError" class="error-msg">请输入用户名（4-20个字符）</div>
                </div>
                
                <div class="form-group">
                    <label>密码 <span style="color: #f44336;">*</span></label>
                    <input type="password" id="password" name="password" placeholder="请输入密码" required>
                    <div class="password-strength"><div id="strengthBar"></div></div>
                    <div id="passwordError" class="error-msg">密码至少6个字符</div>
                </div>
                
                <div class="form-group">
                    <label>确认密码 <span style="color: #f44336;">*</span></label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="请确认密码" required>
                    <div id="confirmError" class="error-msg">两次输入的密码不一致</div>
                </div>
                
                <div class="form-group">
                    <label>电话</label>
                    <input type="tel" id="phone" name="phone" placeholder="请输入电话号码">
                    <div id="phoneError" class="error-msg">请输入有效的电话号码</div>
                </div>
                
                <div class="form-group">
                    <label>邮箱</label>
                    <input type="email" id="email" name="email" placeholder="请输入邮箱地址">
                    <div id="emailError" class="error-msg">请输入有效的邮箱地址</div>
                </div>
                
                <div class="form-group">
                    <label>性别</label>
                    <select id="sex" name="sex">
                        <option value="">请选择</option>
                        <option value="M">男</option>
                        <option value="F">女</option>
                    </select>
                </div>
                
                <button type="submit" class="btn btn-submit">注册</button>
                <button type="button" class="btn btn-secondary" onclick="window.location.href='<%=ctx%>/'">返回首页</button>
            </form>
            
            <div class="login-link">
                已有账号？<a href="<%=ctx%>/user/login">立即登录</a>
            </div>
        </div>
    </div>

    <script>
        var contextPath = '<%=ctx%>';
        
        // 密码强度检测
        document.getElementById('password').addEventListener('input', function() {
            var password = this.value;
            var strengthBar = document.getElementById('strengthBar');
            strengthBar.className = '';
            
            if (password.length === 0) {
                strengthBar.style.width = '0';
                return;
            }
            
            if (password.length < 6) {
                strengthBar.classList.add('strength-weak');
            } else if (password.length < 10 || !/[A-Z]/.test(password) || !/[0-9]/.test(password)) {
                strengthBar.classList.add('strength-medium');
            } else {
                strengthBar.classList.add('strength-strong');
            }
        });

        // 实时表单验证
        document.getElementById('username').addEventListener('blur', function() {
            validateField('username', this.value.length >= 4 && this.value.length <= 20);
        });
        
        document.getElementById('password').addEventListener('blur', function() {
            validateField('password', this.value.length >= 6);
        });
        
        document.getElementById('confirmPassword').addEventListener('blur', function() {
            var password = document.getElementById('password').value;
            validateField('confirm', this.value === password && this.value.length > 0);
        });
        
        document.getElementById('phone').addEventListener('blur', function() {
            var phone = this.value;
            validateField('phone', phone.length === 0 || /^1[3-9]\d{9}$/.test(phone));
        });
        
        document.getElementById('email').addEventListener('blur', function() {
            var email = this.value;
            validateField('email', email.length === 0 || /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email));
        });

        function validateField(field, isValid) {
            var errorDiv = document.getElementById(field === 'confirm' ? 'confirmError' : field + 'Error');
            var input = document.getElementById(field === 'confirm' ? 'confirmPassword' : field);
            
            if (!isValid) {
                input.classList.add('error');
                errorDiv.style.display = 'block';
            } else {
                input.classList.remove('error');
                errorDiv.style.display = 'none';
            }
            return isValid;
        }

        function showMessage(type, text) {
            var messageBox = document.getElementById('messageBox');
            messageBox.className = 'message ' + type;
            messageBox.textContent = text;
            messageBox.style.display = 'block';
        }

        function handleRegister(event) {
            event.preventDefault();
            
            // 验证所有字段
            var isValid = true;
            
            var username = document.getElementById('username').value;
            if (!validateField('username', username.length >= 4 && username.length <= 20)) {
                isValid = false;
            }
            
            var password = document.getElementById('password').value;
            if (!validateField('password', password.length >= 6)) {
                isValid = false;
            }
            
            var confirmPassword = document.getElementById('confirmPassword').value;
            if (!validateField('confirm', confirmPassword === password && confirmPassword.length > 0)) {
                isValid = false;
            }
            
            var phone = document.getElementById('phone').value;
            if (!validateField('phone', phone.length === 0 || /^1[3-9]\d{9}$/.test(phone))) {
                isValid = false;
            }
            
            var email = document.getElementById('email').value;
            if (!validateField('email', email.length === 0 || /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email))) {
                isValid = false;
            }
            
            if (!isValid) {
                showMessage('error', '请检查表单填写是否正确');
                return false;
            }
            
            var formData = new FormData(document.getElementById('registerForm'));
            
            fetch(contextPath + '/user/register', {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.code === 200) {
                    showMessage('success', data.message + '，正在跳转到登录页面...');
                    setTimeout(function() {
                        window.location.href = contextPath + '/user/login';
                    }, 1500);
                } else {
                    showMessage('error', data.message);
                }
            })
            .catch(function(error) {
                showMessage('error', '注册失败：' + error.message);
            });
            
            return false;
        }
    </script>
</body>
</html>