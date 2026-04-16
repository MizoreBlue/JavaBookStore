<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- 顶部信息栏 -->
<div class="top-bar">
  <div class="container">
    <!-- 左侧：Logo -->
    <a href="${pageContext.request.contextPath}/" class="logo">网上书城</a>

    <!-- 右侧：链接 -->
    <div class="top-links">
      <a href="${pageContext.request.contextPath}/cart/list" title="查看购物车">
        <span class="cart-icon">🛒</span> 购物车
      </a>
      <span style="color: #ccc;">|</span>
      <a href="#" title="帮助中心">帮助中心</a>
      <span style="color: #ccc;">|</span>

      <!-- 动态内容区域：判断用户是否登录 -->

      <!-- 情况 1：用户未登录 (session 中没有 user 对象) -->
      <c:if test="${empty sessionScope.user}">
        <a href="${pageContext.request.contextPath}/user/login" title="用户登录">用户登录</a>
      </c:if>

      <!-- 情况 2：用户已登录 (session 中有 user 对象) -->
      <c:if test="${not empty sessionScope.user}">
        <!-- 显示欢迎语 -->
        <span>欢迎，<strong>${sessionScope.user.username}</strong></span>
        <span style="color: #ccc;">|</span>

        <!-- 显示头像 -->
        <a href="${pageContext.request.contextPath}/user/profile" title="个人中心">
          <img src="${pageContext.request.contextPath}/assets/images/user/icon.jpg"
               alt="头像"
               style="height: 24px; width: auto; vertical-align: middle; border-radius: 100%;">
        </a>
        <span style="color: #ccc;">|</span>

        <!-- 退出登录链接 (你需要在这个路径对应的Servlet里做 session.invalidate()) -->
        <a href="${pageContext.request.contextPath}/user/logout" title="退出登录">退出</a>
      </c:if>

    </div>
  </div>
</div>