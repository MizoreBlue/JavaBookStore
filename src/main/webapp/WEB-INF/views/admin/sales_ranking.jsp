<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!-- 页面内部样式 -->
<style>
    .container {
        padding: 20px;
        background: #fff;
        border-radius: 8px;
    }

    .page-title {
        font-size: 18px;
        margin-bottom: 20px;
        border-left: 5px solid #1890ff;
        padding-left: 10px;
        color: #333;
    }

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

    .search-box input, .search-box select {
        padding: 6px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }

    .btn {
        padding: 6px 12px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        color: white;
    }

    .btn-primary {
        background-color: #1890ff;
    }

    .btn-reset {
        background-color: #8c8c8c;
    }

    .btn-add {
        background-color: #52c41a;
    }

    /* 表格样式 */
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    th {
        background-color: #f0f2f5;
        color: #5f5f5f;
        font-weight: 600;
        text-align: left;
        padding: 12px;
        border-bottom: 2px solid #e8e8e8;
    }

    td {
        padding: 12px;
        border-bottom: 1px solid #e8e8e8;
        color: #333;
    }

    tr:hover {
        background-color: #fafafa;
    }

    .action-btn {
        margin-right: 5px;
        text-decoration: none;
        font-size: 14px;
    }

    .edit {
        color: #1890ff;
    }

    .del {
        color: #ff4d4f;
    }
</style>

<div class="container">
    <!-- 页面标题 -->
    <div class="page-title">销量排行榜</div>

    <!-- 搜索区域 (根据需求可以添加时间筛选) -->
    <div class="search-box">
        <input type="text" placeholder="图书名称">
        <input type="text" placeholder="作者">
        <select>
            <option>--全部类别--</option>
            <!-- 这里可以后续通过 Ajax 加载类别 -->
        </select>
        <button class="btn btn-primary">查询</button>
        <button class="btn btn-reset">重置</button>
        <button class="btn btn-add" onclick="getSalesDataToExcel()">导出报表</button>
    </div>

    <!-- 数据表格 -->
    <table>
        <thead>
        <tr>
            <th>排名</th>
            <th>图书名称</th>
            <th>作者</th>
            <th>总销量</th>
        </tr>
        </thead>
        <tbody>
        <!-- 遍历 Servlet 传来的 salesRankDTOS 集合 -->
        <c:forEach items="${salesRankDTOS}" var="rank" varStatus="status">
            <tr>
                <!-- 排名列 (自动根据循环序号生成 1, 2, 3...) -->
                <td style="font-size: 16px; font-weight: bold; color: #333;">
                        ${status.count}
                </td>
                <td>${rank.bookName}</td>
                <td>${rank.author}</td>
                <td>
                    <!-- 格式化销量数字，千位分隔符 -->
                    <fmt:formatNumber value="${rank.totalSales}" pattern="#,###"/>
                </td>
            </tr>
        </c:forEach>

        <!-- 如果没有数据，显示提示 -->
        <c:if test="${empty salesRankDTOS}">
            <tr>
                <td colspan="4" style="text-align: center; padding: 20px; color: #999;">暂无销量数据</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
<script>
    function getSalesDataToExcel() {
        // 注意：路径需确保正确指向你的 Servlet 映射
        fetch("excel", {
            method: 'GET'
        })
            .then((response) => {
                if (!response.ok) {
                    throw new Error("网络响应错误");
                }
                // 【修改点】将响应体解析为 Blob (二进制大对象)，而不是 JSON
                return response.blob();
            })
            .then((blob) => {
                // 【修改点】创建下载链接并自动点击
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = "运营数据报表.xlsx"; // 默认下载的文件名
                document.body.appendChild(a);
                a.click();
                a.remove(); // 下载后移除元素
                window.URL.revokeObjectURL(url); // 释放内存
            })
            .catch(error => {
                console.error("Error:", error);
                alert("系统错误，请查看控制台");
            });
    }
</script>