<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>借阅记录</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --warning: #f8961e;
            --danger: #e63946;
            --light-bg: #f8f9fa;
            --card-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 20px 0;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            width: 100%;
        }

        .header-container {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            padding: 25px 30px;
            margin-bottom: 20px;
            border-radius: 16px 16px 0 0;
            box-shadow: var(--card-shadow);
            position: relative;
        }

        .header-container::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, #4cc9f0, #4895ef);
        }

        .header-title {
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .back-btn {
            background: #4361ee; /* 修改后的颜色 */
            border-radius: 10px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            border: none;
            font-size: 1rem;
            color: white;
            text-decoration: none;
            margin-bottom: 20px;
        }

        .back-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(67, 97, 238, 0.4); /* 使用 rgba 来保持透明度 */
        }

        .table-container {
            background: white;
            border-radius: 0 0 16px 16px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            padding: 30px;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead {
            color: white;
        }

        .table thead th {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            border-radius: 8px;
            padding: 12px 18px;
            font-weight: 600;
            position: relative;
        }

        .table thead th::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(to right, #4cc9f0, #4895ef);
        }

        .table tbody tr {
            border-bottom: 1px solid #edf2f7;
        }

        .table tbody tr:last-child {
            border-bottom: none;
        }

        .table tbody tr:hover {
            background-color: rgba(67, 97, 238, 0.05);
        }

        .btn {
            border-radius: 10px !important;
            padding: 8px 16px !important;
            font-weight: 600 !important;
            transition: all 0.3s !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 8px !important;
            border: none !important;
            font-size: 0.9rem !important;
        }

        .btn-success {
            background: linear-gradient(to right, var(--success), #4895ef);
            color: white !important;
        }

        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.12);
        }

        .btn-sm {
            padding: 5px 10px !important;
            font-size: 0.8rem !important;
        }

        .btn-return {
            background: linear-gradient(to right, #4cc9f0, #4895ef);
            color: white !important;
        }

        .btn-return:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.12);
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 15px;
            }

            .table-container {
                padding: 20px 15px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-container">
        <h1 class="header-title">
            <i class="fas fa-history"></i> 借阅记录
        </h1>
    </div>
    <a href="/library/books" class="back-btn">
        <i class="fas fa-arrow-left"></i> 返回图书列表
    </a>
    <jsp:include page="fragments/navbar.jsp" />
    <div class="table-container">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>图书ID</th>
                <th>图书名称</th>
                <th>借阅人</th>
                <th>借阅日期</th>
                <th>归还日期</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${records}" var="record">
                <tr>
                    <td>${record.id}</td>
                    <td>${record.book.id}</td>
                    <td>${record.book.title}</td>
                    <td>${record.borrowerName}</td>
                    <td>${record.borrowDate}</td>
                    <td>${record.returnDate == null ? '未归还' : record.returnDate}</td>
                    <td>
                        <c:if test="${record.returnDate == null}">
                            <form action="/library/borrows/return/${record.id}" method="post" class="d-inline">
                                <button type="submit" class="btn btn-sm btn-return">归还</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>