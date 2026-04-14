<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // 先定义变量
    String msg = "这是使用jsp：forward从first.jsp页面跳转过来的";
    // 把它放入 pageContext，这样 EL 表达式才能读到
    pageContext.setAttribute("msg", msg);
%>

<jsp:forward page="/admin/home">
    <jsp:param name="msg" value="${msg}" />
</jsp:forward>