<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书管理系统 - 图书列表</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --warning: #f8961e;
            --danger: #e63946;
            --info: #3a86ff;
            --light-bg: #f8f9fa;
            --card-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            padding: 20px 0 50px;
        }

        .library-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 15px;
        }

        .header-section {
            background: white;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            padding: 25px 30px;
            margin-bottom: 25px;
            position: relative;
            overflow: hidden;
        }

        .header-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
        }

        .page-title {
            color: var(--primary);
            font-weight: 700;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
        }

        .page-title i {
            margin-right: 12px;
            font-size: 1.8rem;
        }

        .page-subtitle {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 20px;
        }

        .action-section {
            background: white;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            padding: 20px 25px;
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .btn {
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
        }

        .btn i {
            margin-right: 8px;
        }

        .btn-primary {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            border: none;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.3);
        }

        .btn-info {
            background: linear-gradient(to right, var(--info), var(--primary));
            border: none;
        }

        .search-form {
            background-color: white;
            border-radius: 50px;
            padding: 5px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            display: flex;
            align-items: center;
        }

        .search-form .form-control {
            border: none;
            box-shadow: none !important;
            border-radius: 50px;
            padding: 10px 20px;
            min-width: 300px;
        }

        .search-form .btn {
            border-radius: 50px;
            background: linear-gradient(to right, var(--success), #4895ef);
            border: none;
        }

        .table-section {
            background: white;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            padding: 25px 30px;
            margin-bottom: 25px;
            overflow: hidden;
        }

        .table {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .table thead {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
        }

        .table th {
            font-weight: 600;
            padding: 15px 20px;
        }

        .table td {
            padding: 12px 20px;
            vertical-align: middle;
            border-color: #edf2f7;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(67, 97, 238, 0.03);
        }

        .table-hover tbody tr:hover {
            background-color: rgba(67, 97, 238, 0.08);
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.85rem;
        }

        .status-available {
            background-color: rgba(42, 157, 143, 0.15);
            color: #2a9d8f;
        }

        .status-borrowed {
            background-color: rgba(230, 57, 70, 0.15);
            color: #e63946;
        }

        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 0.875rem;
            border-radius: 6px;
        }

        .btn-warning {
            background: linear-gradient(to right, var(--warning), #f3722c);
            border: none;
        }

        .btn-danger {
            background: linear-gradient(to right, var(--danger), #d90429);
            border: none;
        }

        .btn-success {
            background: linear-gradient(to right, #2a9d8f, #2a9d70);
            border: none;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .borrow-form {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .borrower-input {
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            padding: 6px 12px;
            font-size: 0.875rem;
            transition: all 0.3s;
            width: 120px;
        }

        .borrower-input:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
        }

        .footer-section {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.1;
            color: var(--primary);
        }

        .empty-state p {
            font-size: 1.2rem;
            margin-bottom: 20px;
        }
        .message-section {
            margin-bottom: 20px;
        }

        .alert {
            border-radius: 10px;
            padding: 15px 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        @media (max-width: 768px) {
            .action-section {
                flex-direction: column;
                align-items: stretch;
            }

            .search-form {
                width: 100%;
            }

            .search-form .form-control {
                min-width: auto;
                flex: 1;
            }

            .action-buttons {
                flex-direction: column;
                align-items: flex-start;
            }

            .borrow-form {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
<div class="library-container">
    <!-- 头部区域 -->
    <div class="header-section">
        <h1 class="page-title">
            <i class="fas fa-book"></i>图书管理系统
        </h1>
        <p class="page-subtitle">高效管理您的图书馆藏，追踪借阅状态</p>
    </div>
    <%-- 在页面顶部引入导航栏 --%>
    <jsp:include page="fragments/navbar.jsp" />
    <!-- 操作区域 -->
    <div class="action-section">
        <a href="/library/books/new" class="btn btn-primary">
            <i class="fas fa-plus"></i>添加新书
        </a>

        <form class="d-flex search-form" action="/library/books/search" method="get">
            <input class="form-control me-2" type="search" name="keyword" placeholder="搜索图书...">
            <button class="btn" type="submit">
                <i class="fas fa-search"></i>搜索
            </button>
        </form>
    </div>

    <%-- 在操作区域下方添加全局异常消息显示 --%>
    <div class="message-section">
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show">
                    ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show">
                    ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
    </div>
    <!-- 表格区域 -->
    <div class="table-section">
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>书名</th>
                    <th>作者</th>
                    <th>ISBN</th>
                    <th>出版年份</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty books}">
                        <tr>
                            <td colspan="7">
                                <div class="empty-state">
                                    <i class="fas fa-book-open"></i>
                                    <p>暂无图书数据</p>
                                    <a href="/library/books/new" class="btn btn-primary">
                                        <i class="fas fa-plus"></i>添加第一本书
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${books}" var="book">
                            <tr>
                                <td>${book.id}</td>
                                <td><strong>${book.title}</strong></td>
                                <td>${book.author}</td>
                                <td>${book.isbn}</td>
                                <td>${book.publishYear}</td>
                                <td>
                                            <span class="status-badge ${book.available ? 'status-available' : 'status-borrowed'}">
                                                    ${book.available ? '可借阅' : '已借出'}
                                            </span>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="/library/books/edit/${book.id}" class="btn btn-sm btn-warning">
                                            <i class="fas fa-edit"></i>编辑
                                            <!-- 在操作区域下方添加消息显示 -->
                                            <div class="message-section">
                                                <c:if test="${not empty successMessage}">
                                                    <div class="alert alert-success alert-dismissible fade show">
                                                            ${successMessage}
                                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty errorMessage}">
                                                    <div class="alert alert-danger alert-dismissible fade show">
                                                            ${errorMessage}
                                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </a>
                                        <a href="/library/books/delete/${book.id}" class="btn btn-sm btn-danger">
                                            <i class="fas fa-trash"></i>删除
                                        </a>
                                        <c:if test="${book.available}">
                                            <form class="borrow-form" action="/library/borrows/borrow" method="post">
                                                <input type="hidden" name="bookId" value="${book.id}">
                                                <input type="text" name="borrowerName" class="borrower-input" placeholder="借阅人" required>
                                                <button type="submit" class="btn btn-sm btn-success">
                                                    <i class="fas fa-book-reader"></i>借阅
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>

        <div class="footer-section">
            <a href="/library/borrows" class="btn btn-info">
                <i class="fas fa-history"></i>查看借阅记录
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>