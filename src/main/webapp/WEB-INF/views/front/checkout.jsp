<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>订单结算</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #f5f5f5; }
        .header { background: #337ab7; color: white; padding: 15px 40px; }
        .header h1 { font-size: 20px; }
        .container { max-width: 800px; margin: 30px auto; padding: 0 20px; }
        .card { background: white; border-radius: 8px; padding: 25px; margin-bottom: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .card h2 { font-size: 18px; margin-bottom: 15px; color: #337ab7; }
        form div { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #555; font-size: 14px; }
        input, textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; }
        .item-row { display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px dashed #eee; }
        .total { font-size: 20px; color: #e4393c; font-weight: bold; text-align: right; margin-top: 15px; padding-top: 15px; border-top: 2px solid #337ab7; }
        .btn { padding: 10px 30px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 14px; display: inline-block; }
        .btn-success { background: #5cb85c; color: white; }
        .btn-default { background: #999; color: white; }
        .actions { text-align: right; margin-top: 20px; }
    </style>
</head>
<body>
    <div class="header"><h1>订单结算</h1></div>
    <div class="container">
        <c:if test="${not empty sessionScope.orderError}">
            <div class="error">${sessionScope.orderError}</div>
            <% request.getSession().removeAttribute("orderError"); %>
        </c:if>
        <div class="card">
            <h2>收货信息</h2>
            <form action="${pageContext.request.contextPath}/order" method="post">
                <input type="hidden" name="action" value="place">
                <div><label>收货人姓名</label><input type="text" name="receiverName" required value="${user.username}"></div>
                <div><label>联系电话</label><input type="text" name="receiverPhone" required value="${user.phone}"></div>
                <div><label>收货地址</label><textarea name="address" required rows="3">北京市朝阳区</textarea></div>
            </div>

            <div class="card">
                <h2>商品清单</h2>
                <c:forEach items="${cartList}" var="item">
                    <div class="item-row">
                        <span>${item.name} x ${item.quantity}</span>
                        <span style="color:#e4393c;">¥ ${item.amount}</span>
                    </div>
                </c:forEach>
                <div class="total">应付总额: ¥ ${totalAmount}</div>
                <div class="actions">
                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-default">返回购物车</a>
                    <button type="submit" class="btn btn-success">提交订单</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
