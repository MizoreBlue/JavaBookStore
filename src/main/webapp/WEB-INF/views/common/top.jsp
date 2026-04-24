<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    // 模拟获取当前日期
    String currentDate = new SimpleDateFormat("yyyy年M月d日 E").format(new Date());
%>
<div style="height: 80px; background-color: #FFA500; text-align: center; line-height: 80px; color: #000; font-size: 24px; font-weight: bold; border-bottom: 3px solid #000;">
    网上书城后台管理系统
</div>
<div style="height: 30px; background-color: #f0f0f0; padding: 5px 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #ddd;">
    <span style="font-size: 14px; color: #333;">
        <%= currentDate %>
    </span>
    <span style="font-size: 14px;">
        <a href="#" style="text-decoration: none; color: #333; padding: 3px 8px; background-color: #fff; border: 1px solid #ccc; border-radius: 3px;">退出系统</a>
    </span>
</div>