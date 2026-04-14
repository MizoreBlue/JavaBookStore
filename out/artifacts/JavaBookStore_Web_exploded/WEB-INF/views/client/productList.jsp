<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/common.css">

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--网上书城顶部--%>
<%@include file="../common/head.jsp"%>

<%--网上书城侧边菜单列表--%>
<%@include file="../common/menu_search.jsp"%>

<body>

<%--商品列表主体内容--%>
<div class="main-container">
    <!-- 面包屑导航 -->
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/index">首页</a> &gt; 全部商品
    </div>

    <!-- 页面标题 -->
    <div class="page-header">
        <h2>全部商品目录</h2>
        <span class="total-count">共 ${fn:length(productList)} 件商品</span>
    </div>

    <!-- 商品列表网格 -->
    <div class="product-grid">
        <!-- 使用 JSTL 遍历后端传来的 productList -->
        <c:forEach items="${productList}" var="book">
            <div class="product-card">
                <div class="img-box">
                    <!-- 动态获取图片路径 -->
                    <img src="${pageContext.request.contextPath}/assets/images/productImg/${book.image}" alt="${book.name}">
                </div>
                <div class="info-box">
                    <h3 class="book-name" title="${book.name}">${book.name}</h3>
                    <div class="price-box">
                        <span class="price-symbol">¥</span>
                        <span class="price-num">${book.price}</span>
                    </div>

                    <!-- 表单提交到 HandleAddCartServlet -->
                    <form action="${pageContext.request.contextPath}/ShopCartServlet" method="post">
                        <input type="hidden" name="bookId" value="${book.id}">
                        <input type="hidden" name="PName" value="${book.name}">
                        <input type="hidden" name="Price" value="${book.price}">
                        <input type="hidden" name="Image" value="${book.image}">

                        <div class="action-box">
                            <button type="submit" class="btn-buy">购买</button>
                        </div>
                    </form>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- 页面内嵌样式，建议后期移至 common.css -->
<style>
    /* 主体容器 */
    .main-container {
        width: 1000px;
        margin: 20px auto;
        background-color: #fff;
        padding: 20px;
        border: 1px solid #e0e0e0;
        min-height: 500px;
    }

    /* 面包屑导航 */
    .breadcrumb {
        font-size: 12px;
        color: #666;
        margin-bottom: 15px;
        border-bottom: 1px solid #eee;
        padding-bottom: 10px;
    }
    .breadcrumb a { color: #666; text-decoration: none; }
    .breadcrumb a:hover { color: #ff6700; }

    /* 页面标题区域 */
    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        border-bottom: 2px solid #ff6700;
        padding-bottom: 10px;
    }
    .page-header h2 { margin: 0; font-size: 20px; color: #333; font-weight: normal; }
    .total-count { font-size: 14px; color: #999; }

    /* 商品网格布局 */
    .product-grid {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between; /* 两端对齐 */
        gap: 20px; /* 卡片间距 */
    }

    /* 单个商品卡片 */
    .product-card {
        width: 220px; /* 固定宽度，一行大约放4个 */
        border: 1px solid #f0f0f0;
        padding: 15px;
        transition: all 0.3s;
        text-align: center;
        background: #fff;
    }

    /* 鼠标悬停效果 */
    .product-card:hover {
        border-color: #ff6700;
        box-shadow: 0 0 10px rgba(255, 105, 0, 0.2);
        transform: translateY(-2px);
    }

    /* 图片区域 */
    .img-box {
        height: 250px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 15px;
    }
    .img-box img {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
    }

    /* 书名 */
    .book-name {
        font-size: 14px;
        color: #333;
        font-weight: normal;
        height: 40px; /* 限制高度，防止书名过长撑开布局 */
        overflow: hidden;
        margin: 0 0 10px 0;
        line-height: 1.5;
    }

    /* 价格区域 */
    .price-box {
        color: #ff6700;
        font-size: 18px;
        margin-bottom: 15px;
        font-family: Arial, sans-serif;
    }
    .price-symbol { font-size: 12px; }

    /* 按钮区域 */
    .action-box {
        display: flex;
        justify-content: center;
        gap: 10px;
    }
    .btn-buy, .btn-cart {
        display: inline-block;
        padding: 5px 15px;
        font-size: 12px;
        text-decoration: none;
        border-radius: 2px;
        transition: background 0.2s;
    }
    .btn-buy {
        background-color: #ff6700;
        color: #fff;
        border: 1px solid #ff6700;
    }
    .btn-buy:hover { background-color: #f25800; }

    .btn-cart {
        background-color: #fff;
        color: #ff6700;
        border: 1px solid #ff6700;
    }
    .btn-cart:hover {
        background-color: #ff6700;
        color: #fff;
    }
</style>

<%--网上书城页脚--%>
<%@include file="../common/foot.jsp"%>

</body>