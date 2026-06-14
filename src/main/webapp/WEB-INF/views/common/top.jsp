<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.mizore.entity.Employee" %>
<%
    session = request.getSession(true);
    String currentDate = new SimpleDateFormat("yyyy年M月d日 E").format(new Date());
    Employee admin = (Employee) session.getAttribute("admin");
    String adminName = (admin != null) ? admin.getName() : "管理员";
    String ctx = request.getContextPath();
    if (ctx.equals("/") || ctx.equals("")) { ctx = ""; }
%>
<style>
    .admin-header { background: linear-gradient(135deg, #1e3c72, #2a5298); color: #fff; }
    .admin-header-top { height: 64px; display: flex; justify-content: space-between; align-items: center; padding: 0 30px; }
    .admin-header-top .logo { font-size: 20px; font-weight: bold; letter-spacing: 1px; }
    .admin-header-top .logo span { color: #ffd700; }
    .admin-header-info { height: 36px; background: rgba(255,255,255,0.08); display: flex; justify-content: space-between; align-items: center; padding: 0 30px; font-size: 13px; color: rgba(255,255,255,0.85); }
    .admin-header-info a { color: #ffd700; text-decoration: none; padding: 2px 12px; border: 1px solid rgba(255,255,255,0.3); border-radius: 3px; font-size: 12px; }
    .admin-header-info a:hover { background: rgba(255,255,255,0.15); }
</style>
<div class="admin-header">
    <div class="admin-header-top">
        <div class="logo">📚 网上书城<span>后台管理系统</span></div>
        <div>欢迎您，<strong><%= adminName %></strong></div>
    </div>
    <div class="admin-header-info">
        <span><%= currentDate %></span>
        <a href="<%=ctx%>/backend/login/logout">退出系统</a>
    </div>
</div>