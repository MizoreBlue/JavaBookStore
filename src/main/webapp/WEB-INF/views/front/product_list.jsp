<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>图书列表</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #f5f5f5; }
        .header { background: #337ab7; color: white; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { font-size: 20px; }
        .nav a { color: white; text-decoration: none; margin-left: 20px; }
        .container { max-width: 1200px; margin: 20px auto; padding: 0 20px; }
        .search-box { background: white; padding: 15px; border-radius: 8px; margin-bottom: 20px; display: flex; gap: 10px; align-items: center; }
        .search-box input { flex: 1; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .search-box button { padding: 8px 20px; background: #337ab7; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .categories { display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 20px; }
        .category-tag { background: #fff; padding: 6px 14px; border-radius: 16px; color: #337ab7; text-decoration: none; border: 1px solid #ddd; font-size: 13px; }
        .category-tag:hover, .category-tag.active { background: #337ab7; color: white; }
        .book-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 20px; }
        .book-card { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .book-img { width: 100%; height: 200px; background: #eee; display: flex; align-items: center; justify-content: center; }
        .book-img img { max-width: 100%; max-height: 100%; }
        .book-info { padding: 15px; }
        .book-name { font-size: 16px; color: #333; margin-bottom: 8px; font-weight: bold; }
        .book-author { font-size: 13px; color: #999; margin-bottom: 8px; }
        .book-price { font-size: 18px; color: #e4393c; font-weight: bold; }
        .book-actions { margin-top: 10px; display: flex; gap: 8px; }
        .btn { padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 13px; display: inline-block; }
        .btn-primary { background: #337ab7; color: white; }
        .btn-detail { background: #5cb85c; color: white; }
        .pagination { text-align: center; margin: 30px 0; }
        .pagination a, .pagination span { display: inline-block; padding: 8px 14px; margin: 0 3px; background: white; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #333; }
        .pagination .current { background: #337ab7; color: white; border-color: #337ab7; }
    </style>
</head>
<body>
    <div class="header">
        <h1>图书列表</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/">首页</a>
            <a href="${pageContext.request.contextPath}/product">全部图书</a>
            <a href="${pageContext.request.contextPath}/cart">购物车</a>
            <c:choose>
                <c:when test="${not empty user}">
                    <span>欢迎, ${user.username}</span>
                    <a href="${pageContext.request.contextPath}/user?action=logout">退出</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user?action=login">登录</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="container">
        <div class="search-box">
            <form action="${pageContext.request.contextPath}/product" method="get">
                <input type="text" name="keyword" placeholder="请输入图书名称搜索" value="${keyword}">
                <button type="submit">搜索</button>
            </form>
        </div>

        <div class="categories">
            <a href="${pageContext.request.contextPath}/product" class="category-tag ${empty currentCategory ? 'active' : ''}">全部</a>
            <c:forEach items="${categories}" var="cat">
                <a href="${pageContext.request.contextPath}/product?category=${cat.name}" class="category-tag ${currentCategory eq cat.name ? 'active' : ''}">${cat.name}</a>
            </c:forEach>
        </div>

        <c:if test="${empty pageResult.records}">
            <div style="text-align:center;padding:60px;background:white;border-radius:8px;color:#999;">暂无相关图书</div>
        </c:if>
        <div class="book-grid">
            <c:forEach items="${pageResult.records}" var="book">
                <div class="book-card">
                    <div class="book-img">
                        <c:choose>
                            <c:when test="${not empty book.image}">
                                <c:choose>
                                    <c:when test="${book.image.startsWith('http')}">
                                        <img src="${book.image}" alt="${book.name}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}${book.image}" alt="${book.name}">
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <span style="color:#999;">暂无图片</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="book-info">
                        <div class="book-name">${book.name}</div>
                        <div class="book-author">${book.author} | ${book.category}</div>
                        <div class="book-price">¥ ${book.price}</div>
                        <div class="book-actions">
                            <a href="${pageContext.request.contextPath}/product?action=detail&id=${book.id}" class="btn btn-detail">详情</a>
                            <a href="${pageContext.request.contextPath}/cart?action=add&bookId=${book.id}" class="btn btn-primary">加入购物车</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="pagination">
            <c:if test="${pageResult.pageNum > 1}">
                <a href="${pageContext.request.contextPath}/product?page=${pageResult.pageNum - 1}&category=${currentCategory}&keyword=${keyword}">上一页</a>
            </c:if>
            <span class="current">${pageResult.pageNum} / ${pageResult.pages}</span>
            <c:if test="${pageResult.pageNum < pageResult.pages}">
                <a href="${pageContext.request.contextPath}/product?page=${pageResult.pageNum + 1}&category=${currentCategory}&keyword=${keyword}">下一页</a>
            </c:if>
            <span>共 ${pageResult.total} 本</span>
        </div>
    </div>
</body>
</html>
