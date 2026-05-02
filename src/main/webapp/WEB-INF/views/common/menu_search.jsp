<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!-- 顶部导航栏 -->
<header class="header-container">
    <nav class="nav-wrapper">
        <!-- 左侧：图书分类 -->
        <ul class="category-nav">
            <li><a href="#">文学</a></li>
            <li><a href="#">生活</a></li>
            <li><a href="#">计算机</a></li>
            <li><a href="#">外语</a></li>
            <li><a href="#">经管</a></li>
            <li><a href="#">励志</a></li>
            <li><a href="#">社科</a></li>
            <li><a href="#">学术</a></li>
            <li><a href="#">少儿</a></li>
            <li><a href="#">艺术</a></li>
            <li><a href="#">原版</a></li>
            <li><a href="#">科技</a></li>
            <li><a href="#">考试</a></li>
            <li><a href="#">生活百科</a></li>
            <li class="all-categories"><a href="#">全部商品目录</a></li>
        </ul>

        <!-- 右侧：搜索框 -->
        <div class="search-section">
            <form action="<%=request.getContextPath()%>/product/search" method="get">
                <label for="searchInput">Search</label>
                <input type="text" id="searchInput" name="keyword" class="search-input" placeholder="请输入书名">
                <button type="submit" class="search-btn">搜索</button>
            </form>
        </div>
    </nav>
</header>
