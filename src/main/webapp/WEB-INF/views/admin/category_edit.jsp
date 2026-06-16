<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>分类管理 - 编辑</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #ecf0f1; }
        .container { max-width: 600px; margin: 30px auto; padding: 30px; background: white; border-radius: 8px; }
        h1 { font-size: 20px; color: #2c3e50; margin-bottom: 20px; }
        form div { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #555; font-size: 14px; }
        input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; }
        .btn { padding: 10px 25px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 14px; display: inline-block; color: white; background: #3498db; }
        .btn-default { background: #95a5a6; }
    </style>
</head>
<body>
    <div class="container">
        <h1>${empty category ? '新增' : '编辑'}分类</h1>
        <form action="${pageContext.request.contextPath}/backend/category" method="post">
            <input type="hidden" name="action" value="save">
            <c:if test="${not empty category}"><input type="hidden" name="id" value="${category.id}"></c:if>
            <div><label>分类名称 *</label><input type="text" name="name" required value="${category.name}"></div>
            <div><label>分类类型</label><input type="number" name="type" value="${empty category ? 1 : category.type}"></div>
            <div><label>排序</label><input type="number" name="sort" value="${empty category ? 0 : category.sort}"></div>
            <div><label>状态</label><input type="number" name="status" value="${empty category ? 1 : category.status}"></div>
            <div>
                <button type="submit" class="btn">保存</button>
                <a href="${pageContext.request.contextPath}/backend/category" class="btn btn-default">返回</a>
            </div>
        </form>
    </div>
</body>
</html>
