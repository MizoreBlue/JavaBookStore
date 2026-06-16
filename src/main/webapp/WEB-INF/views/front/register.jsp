<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户注册</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #5cb85c; display: flex; align-items: center; justify-content: center; min-height: 100vh; padding: 20px; }
        .login-box { background: white; padding: 35px; border-radius: 10px; width: 420px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); }
        h1 { text-align: center; color: #5cb85c; margin-bottom: 25px; font-size: 22px; }
        form div { margin-bottom: 12px; }
        label { display: block; margin-bottom: 5px; color: #555; font-size: 13px; }
        input { width: 100%; padding: 9px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; }
        button { width: 100%; padding: 12px; background: #5cb85c; color: white; border: none; border-radius: 4px; font-size: 15px; cursor: pointer; margin-top: 10px; }
        button:hover { background: #449d44; }
        .error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; font-size: 14px; }
        .link { text-align: center; margin-top: 15px; font-size: 14px; }
        .link a { color: #337ab7; text-decoration: none; }
    </style>
</head>
<body>
    <div class="login-box">
        <h1>用户注册</h1>
        <c:if test="${not empty message}"><div class="error">${message}</div></c:if>
        <form action="${pageContext.request.contextPath}/user" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="action" value="doRegister">
            <div><label>用户名 *</label><input type="text" name="username" required minlength="3" maxlength="20" placeholder="3-20个字符"></div>
            <div><label>密码 *</label><input type="password" name="password" required minlength="6" maxlength="20" placeholder="6-20个字符"></div>
            <div><label>确认密码 *</label><input type="password" name="confirmPassword" required placeholder="再次输入密码"></div>
            <div><label>邮箱</label><input type="email" name="email" placeholder="example@mail.com"></div>
            <div><label>手机号</label><input type="text" name="phone" placeholder="11位手机号"></div>
            <div><label>性别</label>
                <select name="sex">
                    <option value="">请选择</option>
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
            </div>
            <button type="submit">注册</button>
        </form>
        <script>
            function validateForm() {
                var pwd = document.getElementsByName('password')[0].value;
                var confirmPwd = document.getElementsByName('confirmPassword')[0].value;
                if (pwd !== confirmPwd) {
                    alert('两次输入的密码不一致');
                    return false;
                }
                return true;
            }
        </script>
        <div class="link"><a href="${pageContext.request.contextPath}/user?action=login">返回登录</a></div>
    </div>
</body>
</html>
