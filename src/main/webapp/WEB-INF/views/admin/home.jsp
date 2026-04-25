<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>网上书城后台</title>
    <style>
        /* 简单布局样式 */
        body { margin: 0; padding: 0; overflow: hidden; }
        /* 使用 Flex 布局让左右并排 */
        .main-container {
            display: flex;
            height: calc(100vh - 60px); /* 假设顶部高度为60px，减去它占满剩余高度 */
        }
        /* 左侧菜单区域 */
        .sidebar {
            width: 200px;
            background-color: #f4f4f4;
            border-right: 1px solid #ddd;
        }
        /* 右侧内容区域 (iframe) */
        .content-area {
            flex: 1; /* 占据剩余所有宽度 */
            height: 100%;
        }
        iframe {
            width: 100%;
            height: 100%;
            border: none; /* 去掉边框 */
        }
    </style>
</head>
<body>

<!-- 1. 包含顶部 -->
<%@ include file="../common/top.jsp" %>

<!-- 2. 主体区域：左侧 + 右侧 -->
<div class="main-container">

    <!-- 左侧菜单 -->
    <div class="sidebar">
        <%@ include file="../common/left.jsp" %>
    </div>

    <!-- 右侧内容：使用 iframe 替换原来的 div -->
    <div class="content-area">
        <!--
             name="mainFrame"：这是关键，左侧菜单的 target 必须指向这个名字
             src="product_list.jsp"：默认加载的页面
        -->
        <iframe name="mainFrame" src="product/list"></iframe>
    </div>

</div>

<%@ include file="../common/bottom.jsp" %>


</body>
</html>