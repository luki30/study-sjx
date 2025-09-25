package com.example.library.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AuthFilter implements Filter {
    private static final Logger logger = LoggerFactory.getLogger(AuthFilter.class);

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 获取当前请求路径
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        logger.debug("请求路径: {}", path);

        // 排除登录页面和登录处理请求
        if (path.equals("/login") ||
                path.startsWith("/static/") ||
                path.startsWith("/swagger-ui") ||
                path.startsWith("/swagger-resources") ||
                path.startsWith("/v2/api-docs") ||  // 添加Swagger文档路径
                path.startsWith("/v3/api-docs") ||  // 添加Swagger文档路径
                path.startsWith("/webjars")) {
            chain.doFilter(request, response);
            return;
        }

        // 检查用户是否已登录
        HttpSession session = httpRequest.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // 未登录，重定向到登录页面
            logger.warn("未授权访问: {}, 重定向到登录页", path);
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        // 用户已登录，继续处理请求
        logger.debug("用户已登录: {}", session.getAttribute("user"));
        chain.doFilter(request, response);
    }
}