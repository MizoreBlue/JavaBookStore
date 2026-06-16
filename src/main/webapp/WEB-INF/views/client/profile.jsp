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
    <title>个人信息</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f5f5f5; }
        .header { background-color: #4CAF50; padding: 15px; color: white; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { font-size: 24px; font-weight: bold; }
        .nav a { color: white; margin-left: 20px; text-decoration: none; }
        .container { max-width: 500px; margin: 30px auto; }
        h2 { color: #333; margin-bottom: 20px; text-align: center; }
        .form-box { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        .btn { padding: 10px 20px; border: none; cursor: pointer; border-radius: 4px; }
        .btn-submit { background-color: #4CAF50; color: white; width: 100%; }
        .btn-submit:hover { opacity: 0.8; }
        .success { color: #4CAF50; text-align: center; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo"><a href="<%=ctx%>/" style="color: white; text-decoration: none;">图书商城</a></div>
            <div class="nav">
                <a href="<%=ctx%>/product/list">商品列表</a>
                <a href="<%=ctx%>/cart?action=view">购物车</a>
                <a href="<%=ctx%>/order/list">我的订单</a>
            </div>
        </div>
    </div>
    <div class="container">
        <h2>个人信息</h2>
        <div id="successMsg" class="success"></div>
        <div class="form-box">
            <form id="profileForm">
                <input type="hidden" name="id" value="${user.id}">
                <div class="form-group">
                    <label>用户名：</label>
                    <input type="text" name="username" value="${user.username}" required>
                </div>
                <div class="form-group">
                    <label>电话：</label>
                    <input type="text" name="phone" value="${user.phone}">
                </div>
                <div class="form-group">
                    <label>邮箱：</label>
                    <input type="email" name="email" value="${user.email}">
                </div>
                <div class="form-group">
                    <label>性别：</label>
                    <select name="sex">
                        <option value="M" ${user.sex == 'M' ? 'selected' : ''}>男</option>
                        <option value="F" ${user.sex == 'F' ? 'selected' : ''}>女</option>
                    </select>
                </div>
                <button type="button" class="btn btn-submit" onclick="updateProfile()">保存修改</button>
            </form>
        </div>
    </div>
    <script>
        var contextPath = '<%=ctx%>';
        
        function updateProfile() {
            const formData = new FormData(document.getElementById('profileForm'));
            fetch(contextPath + '/user/update', {
                method: 'POST',
                body: new URLSearchParams(formData)
            }).then(res => res.json()).then(data => {
                document.getElementById('successMsg').textContent = data.message;
                setTimeout(() => {
                    document.getElementById('successMsg').textContent = '';
                }, 3000);
            });
        }
    </script>
</body>
</html>