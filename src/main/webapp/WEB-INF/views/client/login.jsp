<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户登录</title>
    <!-- 引入与注册页面相同的CSS，保持风格一致 -->
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/common.css">
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/register.css">
    <style>
        /* 针对登录页面的微调，让布局更居中好看 */
        .register-container {
            width: 400px; /* 登录框通常比注册框窄一点 */
            margin: 50px auto;
        }
        .submit-row button {
            width: 100%;
        }
    </style>
</head>
<body>

<%--网上书城顶部--%>
<%@include file="../common/head.jsp"%>

<%--网上书城侧边菜单列表--%>
<%@include file="../common/menu_search.jsp"%>


<!-- 登录主体内容 -->
<div class="register-container">
    <div class="register-title">用户登录</div>

    <!--
      1. action 留空：因为 Servlet 是转发回来的，提交到当前路径即可 (/user/login)
      2. method="post"：对应 Servlet 的 doPost
    -->
    <form action="" method="post">
        <table class="register-table">
            <!-- 用户名 -->
            <tr>
                <td class="td-label">用户名：</td>
                <td class="td-input">
                    <input type="text" name="username"
                           value="${user != null ? user.username : ''}"
                           placeholder="请输入用户名" />
                </td>
            </tr>

            <!-- 密码 -->
            <tr>
                <td class="td-label">密码：</td>
                <td class="td-input">
                    <input type="password" name="password" placeholder="请输入密码" />
                </td>
            </tr>
            <%-- 从 Session 中获取错误信息 --%>
            <% String error = (String) session.getAttribute("loginError"); %>
            <% if (error != null) { %>
            <tr>
                <td colspan="3">
                    <div class="error-msg" style="text-align: center;color: red"><%= error %></div>
                </td>
            </tr>
            <%-- 显示后立即移除，防止刷新页面后一直显示 --%>
            <% session.removeAttribute("loginError"); %>
            <% } %>

            <!-- 分割线 -->
            <tr>
                <td colspan="3"><div class="bottom-dashed"></div></td>
            </tr>

            <!-- 提交按钮 -->
            <tr>
                <td colspan="3" class="submit-row">
                    <button type="submit" class="btn-submit">登 录</button>
                </td>
            </tr>

            <!-- 注册链接 -->
            <tr>
                <td colspan="3" style="text-align: center; padding-top: 15px;">
                    还没有账号？ <a href="${pageContext.request.contextPath}/user/register">去注册</a>
                </td>
            </tr>
        </table>
    </form>
</div>

<%--网上书城页脚--%>
<%@include file="../common/foot.jsp"%>

</body>
</html>