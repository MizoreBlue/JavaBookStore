<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<style>
    /* 侧边栏菜单样式 */
    .menu-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .menu-item {
        border-bottom: 1px solid #34495e;
    }

    .menu-link {
        display: block;
        padding: 15px 20px;
        color: #bdc3c7; /* 浅灰色文字 */
        text-decoration: none;
        font-size: 15px;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
    }

    /* 图标占位 (如果有引入 FontAwesome 可以替换 i 标签) */
    .menu-icon {
        margin-right: 10px;
        width: 20px;
        text-align: center;
    }

    /* 悬停效果 */
    .menu-link:hover {
        background-color: #34495e;
        color: #fff; /* 白色文字 */
        padding-left: 25px; /* 向右滑动动画 */
    }

    /* 当前选中状态 (可选，需配合 JS 实现) */
    .menu-link.active {
        background-color: #1abc9c; /* 亮绿色高亮 */
        color: #fff;
    }
</style>

<div class="sidebar-container">
    <ul class="menu-list">
        <!-- 商品管理 -->
        <li class="menu-item">
            <a href="<%=path%>/backend/product/list" target="mainFrame" class="menu-link">
                <span class="menu-icon">📦</span>
                商品管理
            </a>
        </li>

        <!-- 销售榜单 -->
        <li class="menu-item">
            <a href="#" class="menu-link">
                <span class="menu-icon">📊</span>
                销售榜单
            </a>
        </li>

        <!-- 订单管理 -->
        <li class="menu-item">
            <a href="#" class="menu-link">
                <span class="menu-icon">📝</span>
                订单管理
            </a>
        </li>

        <!-- 公告管理 -->
        <li class="menu-item">
            <a href="#" class="menu-link">
                <span class="menu-icon">📢</span>
                公告管理
            </a>
        </li>
    </ul>
</div>