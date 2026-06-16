<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>个人中心</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #f5f5f5; }
        .header { background: #337ab7; color: white; padding: 15px 40px; }
        .header h1 { font-size: 20px; }
        .container { max-width: 600px; margin: 30px auto; padding: 0 20px; }
        .card { background: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .profile-header { display: flex; align-items: center; margin-bottom: 25px; padding-bottom: 20px; border-bottom: 2px solid #eee; }
        .avatar { width: 80px; height: 80px; background: #337ab7; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 32px; font-weight: bold; margin-right: 20px; }
        .username { font-size: 22px; color: #333; font-weight: bold; }
        .info-label { color: #666; font-size: 14px; margin-top: 10px; }
        form div { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #555; font-size: 14px; }
        input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; }
        .btn { padding: 10px 30px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 14px; display: inline-block; }
        .btn-primary { background: #337ab7; color: white; }
        .btn-default { background: #999; color: white; }
    </style>
</head>
<body>
    <div class="header"><h1>个人中心</h1></div>
    <div class="container">
        <div class="card">
            <div class="profile-header">
                <div class="avatar">${userProfile.username.substring(0,1)}</div>
                <div>
                    <div class="username">${userProfile.username}</div>
                    <div class="info-label">注册时间: ${userProfile.createTime}</div>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/user" method="post">
                <input type="hidden" name="action" value="update">
                <div><label>邮箱</label><input type="email" name="email" value="${userProfile.email}"></div>
                <div><label>手机号</label><input type="text" name="phone" value="${userProfile.phone}"></div>
                <div><label>性别</label><input type="text" name="sex" value="${userProfile.sex}"></div>
                <div><label>头像URL</label><input type="text" name="avatar" value="${userProfile.avatar}"></div>
                <div style="margin-top:20px;">
                    <button type="submit" class="btn btn-primary">保存修改</button>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-default">返回首页</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
