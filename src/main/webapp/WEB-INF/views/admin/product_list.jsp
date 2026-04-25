<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!-- 页面内部样式 -->
<style>
    .container { padding: 20px; background: #fff; border-radius: 8px; }
    .page-title { font-size: 18px; margin-bottom: 20px; border-left: 5px solid #1890ff; padding-left: 10px; color: #333; }

    /* 搜索栏 */
    .search-box {
        background: #f9f9f9;
        padding: 15px;
        border-radius: 4px;
        margin-bottom: 20px;
        display: flex;
        gap: 10px;
        align-items: center;
    }
    .search-box input, .search-box select { padding: 6px; border: 1px solid #ddd; border-radius: 4px; }
    .btn { padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; color: white; }
    .btn-primary { background-color: #1890ff; }
    .btn-reset { background-color: #8c8c8c; }
    .btn-add { background-color: #52c41a; margin-bottom: 10px; display: inline-block; }

    /* 表格样式 */
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    th { background-color: #f0f2f5; color: #5f5f5f; font-weight: 600; text-align: left; padding: 12px; border-bottom: 2px solid #e8e8e8; }
    td { padding: 12px; border-bottom: 1px solid #e8e8e8; color: #333; }
    tr:hover { background-color: #fafafa; }

    .action-btn { margin-right: 5px; text-decoration: none; font-size: 14px; }
    .edit { color: #1890ff; }
    .del { color: #ff4d4f; }
</style>

<div class="container">
    <div class="page-title">商品列表管理</div>

    <!-- 搜索区域 -->
    <div class="search-box">
        <input type="text" placeholder="商品编号">
        <input type="text" placeholder="商品名称">
        <select><option>--选择商品类别--</option></select>
        <button class="btn btn-primary">查询</button>
        <button class="btn btn-reset">重置</button>
    </div>

    <a href="${pageContext.request.contextPath}backend/product/add" class="btn btn-add" target="mainFrame">+ 添加商品</a>

    <!-- 数据表格 -->
    <table>
        <thead>
        <tr>
            <th>商品编号</th>
            <th>商品名称</th>
            <th>商品价格</th>
            <th>商品数量</th>
            <th>商品类别</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <!-- 遍历 Servlet 传来的 products 集合 -->
        <c:forEach items="${products}" var="book">
            <tr>
                <td style="font-family: monospace; font-size: 12px; color: #888;">${book.id}</td>
                <td>${book.name}</td>
                <td><fmt:formatNumber value="${book.price}" pattern="0.00"/></td>
                <td>${book.stock}</td>
                <td>${book.category}</td>
                <td>
                    <a href="#" class="action-btn edit">编辑</a>
                    <a href="#" class="action-btn del">删除</a>
                </td>
            </tr>
        </c:forEach>

        <!-- 如果没有数据，显示提示 -->
        <c:if test="${empty products}">
            <tr>
                <td colspan="6" style="text-align: center; padding: 20px; color: #999;">暂无商品数据</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>