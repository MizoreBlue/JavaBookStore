<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>购物车</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #f5f5f5; }
        .header { background: #337ab7; color: white; padding: 15px 40px; }
        .header h1 { font-size: 20px; }
        .container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }
        table { width: 100%; background: white; border-collapse: collapse; box-shadow: 0 2px 8px rgba(0,0,0,0.08); border-radius: 8px; overflow: hidden; }
        th { background: #337ab7; color: white; padding: 15px; text-align: left; }
        td { padding: 15px; border-bottom: 1px solid #eee; }
        tr:hover { background: #f9f9f9; }
        .book-img-small { width: 60px; height: 60px; background: #eee; display: flex; align-items: center; justify-content: center; border-radius: 4px; }
        .empty { text-align: center; padding: 60px; color: #999; font-size: 16px; background: white; border-radius: 8px; }
        .summary { background: white; padding: 20px; margin-top: 20px; border-radius: 8px; text-align: right; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .total-price { font-size: 24px; color: #e4393c; font-weight: bold; }
        .btn { padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 13px; display: inline-block; }
        .btn-primary { background: #337ab7; color: white; }
        .btn-success { background: #5cb85c; color: white; }
        .btn-danger { background: #d9534f; color: white; }
        .actions { display: flex; gap: 10px; justify-content: flex-end; margin-top: 20px; }
        input[type="number"] { width: 60px; padding: 4px; border: 1px solid #ddd; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="header"><h1>购物车</h1></div>
    <div class="container">
        <c:choose>
            <c:when test="${empty cartList}">
                <div class="empty">购物车是空的, <a href="${pageContext.request.contextPath}/product" style="color:#337ab7;">去逛逛</a></div>
            </c:when>
            <c:otherwise>
                <table>
                    <tr><th>图书</th><th>书名</th><th>单价</th><th>数量</th><th>小计</th><th>操作</th></tr>
                    <c:forEach items="${cartList}" var="item">
                        <tr>
                            <td>
                                <div class="book-img-small">
                                    <c:choose>
                                        <c:when test="${not empty item.image}">
                                            <c:choose>
                                                <c:when test="${item.image.startsWith('http')}">
                                                    <img src="${item.image}" style="max-width:100%;max-height:100%;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}${item.image}" style="max-width:100%;max-height:100%;">
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>无图</c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                            <td>${item.name}</td>
                            <td>¥ ${item.price}</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="bookId" value="${item.bookId}">
                                    <input type="number" name="quantity" value="${item.quantity}" min="1" onchange="this.form.submit()">
                                </form>
                            </td>
                            <td style="color:#e4393c;font-weight:bold;">¥ ${item.amount}</td>
                            <td><a href="${pageContext.request.contextPath}/cart?action=remove&bookId=${item.bookId}" class="btn btn-danger">删除</a></td>
                        </tr>
                    </c:forEach>
                </table>

                <div class="summary">
                    <div>合计: <span class="total-price">¥ ${totalAmount}</span></div>
                </div>

                <div class="actions">
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-primary">继续购物</a>
                    <a href="${pageContext.request.contextPath}/cart?action=clear" class="btn btn-danger">清空购物车</a>
                    <a href="${pageContext.request.contextPath}/order?action=checkout" class="btn btn-success">去结算</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
