<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>图书详情 - ${book.name}</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #f5f5f5; }
        .header { background: #337ab7; color: white; padding: 15px 40px; }
        .header h1 { font-size: 20px; }
        .container { max-width: 1000px; margin: 30px auto; padding: 0 20px; }
        .detail-card { background: white; border-radius: 8px; padding: 30px; display: flex; gap: 30px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .book-image { width: 300px; height: 400px; background: #eee; display: flex; align-items: center; justify-content: center; border-radius: 8px; }
        .book-image img { max-width: 100%; max-height: 100%; }
        .book-detail { flex: 1; }
        .book-title { font-size: 28px; color: #333; margin-bottom: 15px; }
        .book-meta { color: #666; margin-bottom: 10px; font-size: 14px; }
        .book-price { font-size: 32px; color: #e4393c; font-weight: bold; margin: 20px 0; }
        .book-desc { color: #666; line-height: 1.8; margin: 20px 0; padding: 15px; background: #f9f9f9; border-radius: 6px; }
        .actions { display: flex; gap: 15px; margin-top: 30px; }
        .btn { padding: 12px 30px; border: none; border-radius: 6px; cursor: pointer; text-decoration: none; font-size: 15px; display: inline-block; }
        .btn-primary { background: #337ab7; color: white; }
        .btn-back { background: #777; color: white; }
        .back-link { display: inline-block; margin-top: 20px; color: #337ab7; text-decoration: none; }
    </style>
</head>
<body>
    <div class="header"><h1>图书详情</h1></div>
    <div class="container">
        <div class="detail-card">
            <div class="book-image">
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
            <div class="book-detail">
                <div class="book-title">${book.name}</div>
                <div class="book-meta">作者: ${book.author}</div>
                <div class="book-meta">分类: ${book.category}</div>
                <div class="book-meta">库存: ${book.stock} 本</div>
                <div class="book-price">¥ ${book.price}</div>
                <div class="book-desc">
                    <strong>内容简介:</strong><br>
                    ${book.description}
                </div>
                <div class="actions">
                    <a href="${pageContext.request.contextPath}/cart?action=add&bookId=${book.id}" class="btn btn-primary">加入购物车</a>
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-back">返回列表</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
