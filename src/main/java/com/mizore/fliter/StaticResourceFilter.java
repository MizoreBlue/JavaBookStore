package com.mizore.fliter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * 静态资源过滤器
 * 作用：拦截所有请求，如果是静态资源（css/js/img），则设置缓存策略并放行
 */
@WebFilter("/*") // 拦截所有请求
public class StaticResourceFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 过滤器初始化时调用，一般用于加载配置，这里暂时留空
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // 1. 强转协议对象（为了使用 HTTP 特有的方法）
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 2. 获取请求的 URI (例如: /JavaBookStore/assets/css/common.css)
        String uri = httpRequest.getRequestURI();

        // 3. 判断是否为静态资源
        // 如果 URI 包含这些后缀，我们就认为它是静态资源
        if (isStaticResource(uri)) {
            // --- 你的核心逻辑：设置缓存头 ---
            // max-age=3600 表示浏览器缓存 3600秒 (1小时)
            // 在此期间，浏览器不会向服务器发送请求，直接读本地缓存，极大提升加载速度
//            TODO 设置缓存头
//            httpResponse.setHeader("Cache-Control", "max-age=3600");

            // 可选：如果你希望浏览器永远不缓存（开发调试阶段），可以设置为：
            httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            RequestDispatcher rd = request.getServletContext().getNamedDispatcher("default");
            rd.forward(request, response);
            return;
//
        }

        // 4. 放行！非常重要
        // 如果不调用这个方法，请求就会卡在这里，页面无法显示
        chain.doFilter(request, response);
    }

    public void destroy() {
        // 过滤器销毁时调用，用于释放资源，这里暂时留空
    }

    /**
     * 辅助方法：根据 URI 判断是否为静态资源
     */
    private boolean isStaticResource(String uri) {
        // 定义常见的静态资源后缀
        return uri.endsWith(".css") ||
                uri.endsWith(".js") ||
                uri.endsWith(".png") ||
                uri.endsWith(".jpg") ||
                uri.endsWith(".jpeg") ||
                uri.endsWith(".gif") ||
                uri.endsWith(".ico") ||
                uri.endsWith(".svg") ||
                uri.endsWith(".woff") ||
                uri.endsWith(".ttf");
    }
}