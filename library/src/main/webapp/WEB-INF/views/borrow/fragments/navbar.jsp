<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/books">图书馆管理系统</a>

        <div class="d-flex align-items-center">
            <c:if test="${not empty sessionScope.user}">
                <span class="me-3">欢迎，${sessionScope.user}</span>
                <a class="btn btn-sm btn-outline-danger"
                   href="${pageContext.request.contextPath}/logout">退出</a>
            </c:if>
        </div>
    </div>
</nav>