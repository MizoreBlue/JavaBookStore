<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            margin-top: 20px;
        }

        .page-title {
            font-size: 18px;
            margin-bottom: 20px;
            border-left: 5px solid #1890ff;
            padding-left: 10px;
            color: #333;
        }

        /* 状态标签样式 */
        .status-pending { color: #faad14; font-weight: 500; } /* 待付款 */
        .status-processing { color: #1890ff; font-weight: 500; } /* 待发货 */
        .status-shipped { color: #52c41a; font-weight: 500; } /* 已发货 */
        .status-completed { color: #8c8c8c; font-weight: 500; } /* 已完成 */
        .status-cancelled { color: #ff4d4f; font-weight: 500; } /* 已取消 */

        /* 操作按钮 */
        .action-btn {
            margin-right: 5px;
            text-decoration: none;
            font-size: 14px;
        }

        .btn-view { background-color: #1890ff; color: white; }
        .btn-delete { background-color: #ff4d4f; color: white; }

        /* 订单详情模态框中的表格 */
        .modal-table th { background-color: #f8f9fa; }
    </style>

<div class="container">
    <!-- 页面标题 -->
    <div class="page-title">订单管理列表</div>

    <!-- 搜索与操作栏 -->
    <div class="search-box d-flex justify-content-between mb-4">
        <div>
            <input type="text" id="orderSearch" placeholder="请输入订单ID或收件人" class="form-control me-2 d-inline-block" style="width: 250px;">
            <button class="btn btn-primary" onclick="searchOrders()">查询</button>
            <button class="btn btn-reset" onclick="resetSearch()">重置</button>
        </div>
        <div>
            <button class="btn btn-add" onclick="exportOrders()">导出报表</button>
        </div>
    </div>

    <!-- 数据表格 -->
    <table class="table table-hover align-middle">
        <thead class="table-light">
        <tr>
            <th>订单ID</th>
            <th>订单金额</th>
            <th>收货信息</th>
            <th>下单时间</th>
            <th>订单状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <!-- 遍历 Servlet 传来的 orderVOList 集合 -->
        <c:forEach items="${orderVOList}" var="orderVo">
            <tr>
                <!-- 订单ID -->
                <td><small class="text-muted">${orderVo.orders.id}</small></td>

                <!-- 订单金额 -->
                <td>
                    <fmt:formatNumber value="${orderVo.orders.totalAmount}" type="currency" currencySymbol="¥"/>
                </td>

                <!-- 收货信息 -->
                <td>
                    <div>收件人: ${orderVo.orders.receiverName}</div>
                    <div>电话: ${orderVo.orders.receiverPhone}</div>
                    <div>地址: ${orderVo.orders.address}</div>
                </td>

                <!-- 下单时间 -->
                <td>
                    <fmt:formatDate value="${orderVo.orders.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>

                <!-- 订单状态 (根据 status 数字显示不同文本和样式) -->
                <td>
                    <c:choose>
                        <c:when test="${orderVo.orders.status == 0}"><span class="status-pending">待付款</span></c:when>
                        <c:when test="${orderVo.orders.status == 1}"><span class="status-processing">待发货</span></c:when>
                        <c:when test="${orderVo.orders.status == 2}"><span class="status-shipped">已发货</span></c:when>
                        <c:when test="${orderVo.orders.status == 3}"><span class="status-completed">已完成</span></c:when>
                        <c:otherwise><span class="status-cancelled">已取消</span></c:otherwise>
                    </c:choose>
                </td>

                <!-- 操作按钮 -->
                <td>
                    <!-- 查看详情按钮，点击触发模态框 -->
                    <button class="btn btn-view btn-sm action-btn"
                            data-bs-toggle="modal"
                            data-bs-target="#detailModal"
                            onclick="loadOrderDetails(${orderVo.orders.id})">
                        详情
                    </button>
                    <!-- 删除按钮 (示例，实际需确认逻辑) -->
                    <button class="btn btn-delete btn-sm action-btn"
                            onclick="deleteOrder(${orderVo.orders.id})">
                        删除
                    </button>
                </td>
            </tr>
        </c:forEach>

        <!-- 如果没有数据，显示提示 -->
        <c:if test="${empty orderVOList}">
            <tr>
                <td colspan="6" class="text-center text-muted py-5">
                    暂无订单数据
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<!-- 订单详情模态框 (Modal) -->
<div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detailModalLabel">订单详情 - <span id="modalOrderId"></span></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>书籍图片</th>
                        <th>书籍名称</th>
                        <th>数量</th>
                        <th>单价</th>
                        <th>小计</th>
                    </tr>
                    </thead>
                    <tbody id="modalDetailBody">
                    <!-- 动态内容由 JavaScript 插入 -->
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!-- 引入 Bootstrap Bundle (包含 Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 模拟数据或通过后端接口获取详情
    // 这里为了演示，直接使用 JSP 输出的 JSON 数据结构
    const allOrderData = {
        <c:forEach items="${orderVOList}" var="orderVo" varStatus="status">
        "${orderVo.orders.id}": [
            <c:forEach items="${orderVo.orderDetailList}" var="detail" varStatus="detailStatus">
            {
                "bookName": "${detail.book.name}", // 假设 OrderDetail 关联了 Book 对象或有 name 属性
                "image": "${detail.image}",
                "number": ${detail.number},
                "amount": ${detail.amount}
            }<c:if test="${!detailStatus.last}">,</c:if>
            </c:forEach>
        ]<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    };

    // 加载订单详情到模态框
    function loadOrderDetails(orderId) {
        document.getElementById('modalOrderId').textContent = orderId;
        const tbody = document.getElementById('modalDetailBody');
        tbody.innerHTML = ''; // 清空旧数据

        const details = allOrderData[orderId] || [];
        if (details.length === 0) {
            tbody.innerHTML = '<tr><td colspan="5" class="text-center">暂无商品详情</td></tr>';
            return;
        }

        details.forEach(detail => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td><img src="${detail.image}" alt="书籍图片" style="width: 50px; height: 50px; object-fit: cover;"></td>
                <td>${detail.bookName}</td>
                <td>× ${detail.number}</td>
                <td><fmt:formatNumber value="${detail.amount}" type="currency" currencySymbol="¥"/></td>
                <td><fmt:formatNumber value="${detail.amount * detail.number}" type="currency" currencySymbol="¥"/></td>
            `;
            tbody.appendChild(row);
        });
    }

    // 搜索功能 (简单示例)
    function searchOrders() {
        const input = document.getElementById('orderSearch').value.toLowerCase();
        const table = document.querySelector('table');
        const tr = table.querySelectorAll('tbody tr');

        tr.forEach(row => {
            const txtValue = row.textContent || row.innerText;
            row.style.display = txtValue.toLowerCase().includes(input) ? "" : "none";
        });
    }

    function resetSearch() {
        document.getElementById('orderSearch').value = '';
        searchOrders();
    }

    // 导出功能 (与之前的 Excel 导出逻辑一致)
    function exportOrders() {
        fetch("${path}/admin/order/export", {
            method: 'GET'
        })
            .then(response => {
                if (!response.ok) throw new Error("导出失败");
                return response.blob();
            })
            .then(blob => {
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = "订单数据报表.xlsx";
                document.body.appendChild(a);
                a.click();
                a.remove();
                window.URL.revokeObjectURL(url);
            })
            .catch(error => {
                console.error("Error:", error);
                alert("导出出错，请重试");
            });
    }

    // 删除订单 (示例)
    function deleteOrder(id) {
        if (confirm("确定要删除该订单吗？")) {
            // 这里需要调用删除接口
            alert("删除功能待实现 (ID: " + id + ")");
        }
    }
</script>