<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>系统错误</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .error-container {
            max-width: 600px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .error-header {
            background: linear-gradient(to right, #e63946, #d90429);
            color: white;
            padding: 25px 30px;
            text-align: center;
        }

        .error-body {
            padding: 35px 40px;
        }

        .error-icon {
            font-size: 4rem;
            color: #e63946;
            margin-bottom: 20px;
        }

        .error-details {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-top: 20px;
            font-family: monospace;
            max-height: 200px;
            overflow-y: auto;
        }

        .btn-home {
            background: linear-gradient(to right, #4361ee, #3f37c9);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px 24px;
            font-weight: 600;
            transition: all 0.3s;
            margin-top: 25px;
        }

        .btn-home:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(67, 97, 238, 0.4);
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-header">
        <h1><i class="fas fa-exclamation-triangle"></i> 系统错误</h1>
    </div>

    <div class="error-body text-center">
        <div class="error-icon">
            <i class="fas fa-bug"></i>
        </div>

        <h3 class="mb-3">抱歉，系统发生意外错误</h3>
        <p>我们的技术团队已收到此错误通知，将尽快修复问题</p>

        <c:if test="${not empty errorMessage}">
            <div class="error-details">
                <strong>错误详情:</strong>
                <p>${errorMessage}</p>
            </div>
        </c:if>

        <a href="/library/books" class="btn btn-home">
            <i class="fas fa-home"></i> 返回首页
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>