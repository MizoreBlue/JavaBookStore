<script src="<%=request.getContextPath()%>/assets/js/register.js" type="text/javascript"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/register.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/common.css">

<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<body>
<%--网上书城顶部--%>
<%@include file="../common/head.jsp"%>

<%--网上书城侧边菜单列表--%>
<%@include file="../common/menu_search.jsp"%>

<!-- 注册主体内容 -->
<div class="register-container">
    <div class="register-title">新用户注册</div>

    <form id="registerForm">
        <table class="register-table">
            <!-- 邮箱 -->
            <tr>
                <td class="td-label">邮箱：</td>
                <td class="td-input"><input type="text" name="email" /></td>
                <td class="td-tip">请输入有效的邮箱地址</td>
            </tr>

            <!-- 用户名 -->
            <tr>
                <td class="td-label">用户名：</td>
                <td class="td-input"><input type="text" name="username" /></td>
                <td class="td-tip">字母数字下划线1到10位, 不能是数字开头</td>
            </tr>

            <!-- 密码 -->
            <tr>
                <td class="td-label">密码：</td>
                <td class="td-input"><input type="password" name="password" /></td>
                <td class="td-tip" rowspan="2">密码请设置6-16位字符</td>
            </tr>

            <!-- 重复密码 -->
            <tr>
                <td class="td-label">重复密码：</td>
                <td class="td-input"><input type="password" name="repassword" /></td>
            </tr>

            <!-- 性别 -->
            <tr>
                <td class="td-label">性别：</td>
                <td class="td-input">
                    <div class="gender-group">
                        <label><input type="radio" name="gender" value="male" checked="checked"/> 男</label>
                        <label><input type="radio" name="gender" value="female"/> 女</label>
                    </div>
                </td>
                <td class="td-tip"></td>
            </tr>

            <!-- 联系电话 -->
            <tr>
                <td class="td-label">联系电话：</td>
                <td class="td-input"><input type="tel" name="telephone" /></td>
                <td class="td-tip"></td>
            </tr>

            <!-- 个人介绍 -->
            <tr>
                <td class="td-label">个人介绍：</td>
                <td colspan="2"><textarea name="introduce"></textarea></td>
            </tr>

            <!-- 分割线 -->
            <tr>
                <td colspan="3"><div class="bottom-dashed"></div></td>
            </tr>

            <!-- 提交按钮 -->
            <tr>
                <td colspan="3" class="submit-row">
                    <button type="button" class="btn-submit" onclick="submitRegister()">同意并提交</button>
                </td>
            </tr>
        </table>
    </form>
</div>


<%--网上书城页脚--%>
<%@include file="../common/foot.jsp"%>

</body>