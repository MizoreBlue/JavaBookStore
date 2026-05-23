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
<div id="orderDetailModal" style="display: none; position: fixed; top: 10%; left: 50%; transform: translateX(-50%); width: 600px; background: white; border: 1px solid #ccc; box-shadow: 0 4px 8px rgba(0,0,0,0.2); z-index: 1000; padding: 20px; border-radius: 5px;">
    <h3>订单详情 <span style="float: right; cursor: pointer;" onclick="closeModal()">×</span></h3>
    <hr>
    <div id="detailContent">
        <!-- 书籍列表将通过 JS 动态插入到这里 -->
    </div>
</div>
<!-- 遮罩层 -->
<div id="modalBackdrop" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999;"></div>
<!-- 引入 Bootstrap Bundle (包含 Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 1. 定义一个函数来显示模态框并填充数据
    function showOrderDetail(orderId, orderDetails) {
        // 获取模态框和遮罩层元素
        var modal = document.getElementById('orderDetailModal');
        var backdrop = document.getElementById('modalBackdrop');
        var contentDiv = document.getElementById('detailContent');

        // 清空之前的内容
        contentDiv.innerHTML = '';

        // 2. 遍历后端传过来的 orderDetails 数组
        // 根据你提供的数据，orderDetails 是一个包含 OrderDetail 对象的数组
        orderDetails.forEach(function(detail) {
            // 提取书籍信息 (Book 对象)
            var book = detail.book;
            var bookName = book ? book.name : '未知书籍';
            var author = book ? book.author : '未知作者';
            var price = detail.amount; // 单价
            var quantity = detail.number; // 数量
            var image = book && book.image ? book.image : '/images/default-book.png'; // 使用默认图片防止空指针

            // 3. 创建并拼接 HTML 字符串
            // 这里采用了简单的 div 布局，你可以根据需要美化
            var itemHtml = `
            <div style="display: flex; margin-bottom: 15px; padding-bottom: 15px; border-bottom: 1px dashed #eee;">
                <!-- 书籍图片 -->
                <div style="width: 80px; height: 100px; margin-right: 15px;">
                    <img src="${image}" alt="${bookName}" style="width: 100%; height: 100%; object-fit: cover;">
                </div>
                <!-- 书籍信息 -->
                <div style="flex: 1;">
                    <h4 style="margin: 0 0 8px 0; color: #333;">${bookName}</h4>
                    <p style="margin: 5px 0; color: #666; font-size: 14px;"><strong>作者：</strong>${author}</p>
                    <p style="margin: 5px 0; color: #666; font-size: 14px;"><strong>单价：</strong>¥${price}</p>
                    <p style="margin: 5px 0; color: #666; font-size: 14px;"><strong>数量：</strong>${quantity} 本</p>
                </div>
            </div>
        `;

            // 将生成的 HTML 添加到内容区域
            contentDiv.innerHTML += itemHtml;
        });

        // 显示模态框和遮罩层
        modal.style.display = 'block';
        backdrop.style.display = 'block';
    }

    // 4. 关闭模态框的函数
    function closeModal() {
        document.getElementById('orderDetailModal').style.display = 'none';
        document.getElementById('modalBackdrop').style.display = 'none';
    }

</script>