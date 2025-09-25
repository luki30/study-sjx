<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <!-- 左侧品牌标识 (保留空间) -->
        <a class="navbar-brand" href="#">
            <i class="fas fa-book me-2"></i>图书系统
        </a>

        <!-- 右侧用户信息 -->
        <div class="d-flex justify-content-end align-items-center w-100">
            <c:if test="${not empty sessionScope.user}">
                <span class="me-3 text-muted">
                    <i class="fas fa-user-circle me-1"></i>${sessionScope.user}
                </span>
                <a class="btn btn-sm btn-outline-danger"
                   href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt me-1"></i>退出
                </a>
            </c:if>
        </div>
    </div>
</nav>