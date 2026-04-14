<script src="<%=request.getContextPath()%>/assets/js/index.js" type="text/javascript"></script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/index.css">
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/common.css">

<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<body>
<%--网上书城顶部--%>
<%@include file="../common/head.jsp"%>

<%--网上书城侧边菜单列表--%>
<%@include file="../common/menu_search.jsp"%>

<!-- 轮播图 -->
<div class="carousel">
    <img src="<%=request.getContextPath()%>/assets/images/ad/index_ad0.jpg" class="active" alt="轮播图1">
    <img src="<%=request.getContextPath()%>/assets/images/ad/index_ad1.jpg" alt="轮播图2">
    <img src="<%=request.getContextPath()%>/assets/images/ad/index_ad2.jpg" alt="轮播图3">
    <img src="<%=request.getContextPath()%>/assets/images/ad/index_ad3.jpg" alt="轮播图4">
    <img src="<%=request.getContextPath()%>/assets/images/ad/index_ad4.jpg" alt="轮播图5">
    <img src="<%=request.getContextPath()%>/assets/images/ad/index_ad5.jpg" alt="轮播图6">
    <img src="<%=request.getContextPath()%>/assets/images/ad/index_ad6.jpg" alt="轮播图7">
    <div class="carousel-indicators">
        <span class="active" data-index="0"></span>
        <span data-index="1"></span>
        <span data-index="2"></span>
        <span data-index="3"></span>
        <span data-index="4"></span>
        <span data-index="5"></span>
    </div>
</div>

<!-- 公告板 -->
<div class="announcement">
    <h3>公告板</h3>
    <p>尊敬的网上书城用户：</p>
    <p>为了让大家有更好的购物体验，3月25日起，当日达业务关小黑屋回炉升级！</p>
    <p>具体开放时间请留意公告，感谢大家的支持与理解，祝大家购物愉快！</p>
</div>

<!-- 本周热卖 -->
<div class="hot-sales">
    <h3>本周热卖</h3>
    <p>这里可以展示本周热销书籍或推荐商品。</p>
</div>


<%--网上书城页脚--%>
<%@include file="../common/foot.jsp"%>

</body>