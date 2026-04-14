<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    // 1. 请求预处理：解决中文乱码
    request.setCharacterEncoding("UTF-8");

    // 2. 获取购物车集合（从 session 作用域）
    // 如果 session 中没有名为 "cart" 的属性，则返回 null
    List<Map<String, String>> cart = (List<Map<String, String>>) session.getAttribute("cart");

    // 3. 初始化购物车（首次访问时创建）
    if (cart == null) {
        cart = new ArrayList<>();
        session.setAttribute("cart", cart);
    }

    // 4. 商品数据封装
    // 获取表单提交的数据
    String name = request.getParameter("PName");
    String price = request.getParameter("Price");
    String stock = request.getParameter("PNum");
    String image = request.getParameter("Image");

    // 创建商品信息映射表 item
    Map<String, String> item = new HashMap<>();
    item.put("name", name);
    item.put("price", price);
    item.put("stock", stock);
    item.put("image", image);

    // 5. 数据持久化：将商品 item 加入购物车 cart
    cart.add(item);

    // 6. 页面跳转：重定向回购物车页面
    // 注意路径要写对，假设 Cart.jsp 也在 client 目录下
    response.sendRedirect("shopCart");
%>