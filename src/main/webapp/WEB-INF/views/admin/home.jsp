<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>网上书城后台</title>
</head>
<body style="margin: 0; padding: 0;">
<!-- 1. 包含顶部 -->
<%@ include file="layout/top.jsp" %>

<!-- 2. 包含左侧菜单 -->
<%@ include file="../common/left.jsp" %>

<!-- 3. 包含中间内容 -->
<div class="content" style="text-align: center;font-size: 20px">
    <%=request.getParameter("msg")%>
</div>
<!-- 4. 包含底部 -->
<%@ include file="layout/bottom.jsp" %>
</body>
</html>