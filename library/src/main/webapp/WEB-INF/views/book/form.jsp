<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${book.id == null ? '添加' : '编辑'}图书</title>
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

        .form-container {
            max-width: 800px;
            margin: 0 auto;
            width: 100%;
        }

        .form-card {
            background: white;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }

        .form-header {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            padding: 25px 30px;
            position: relative;
        }

        .form-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, #4cc9f0, #4895ef);
        }

        .form-title {
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .form-body {
            padding: 35px 40px;
        }

        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-control {
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px 18px;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
        }

        .input-group-icon {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #718096;
            z-index: 10;
        }

        .input-with-icon {
            padding-left: 45px;
        }

        .btn {
            border-radius: 10px;
            padding: 12px 24px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            border: none;
            font-size: 1rem;
        }

        .btn-primary {
            background: linear-gradient(to right, var(--primary), var(--secondary));
        }

        .btn-secondary {
            background: linear-gradient(to right, #718096, #4a5568);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.12);
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #edf2f7;
        }

        .form-row {
            margin-bottom: 25px;
            position: relative;
        }

        .form-row:last-child {
            margin-bottom: 0;
        }

        .form-note {
            color: #718096;
            font-size: 0.9rem;
            margin-top: 6px;
            margin-left: 5px;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 0 15px;
            }

            .form-body {
                padding: 25px;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="form-container">
    <div class="form-card">
        <div class="form-header">
            <h1 class="form-title">
                <i class="fas ${book.id == null ? 'fa-plus-circle' : 'fa-edit'}"></i>
                ${book.id == null ? '添加新书' : '编辑图书'}
            </h1>
        </div>

        <jsp:include page="fragments/navbar.jsp" />
        <div class="form-body">
            <form method="post" action="/library/books">
                <c:if test="${book.id != null}">
                    <input type="hidden" name="id" value="${book.id}">
                </c:if>

                <div class="form-row">
                    <label class="form-label">
                        <i class="fas fa-book"></i> 书名
                    </label>
                    <div class="input-group-icon">
                        <i class="fas fa-heading input-icon"></i>
                        <input type="text" class="form-control input-with-icon"
                               name="title" value="${book.title}"
                               placeholder="请输入书名" required>
                    </div>
                </div>

                <div class="form-row">
                    <label class="form-label">
                        <i class="fas fa-user-edit"></i> 作者
                    </label>
                    <div class="input-group-icon">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" class="form-control input-with-icon"
                               name="author" value="${book.author}"
                               placeholder="请输入作者姓名" required>
                    </div>
                </div>

                <div class="form-row">
                    <label class="form-label">
                        <i class="fas fa-barcode"></i> ISBN
                    </label>
                    <div class="input-group-icon">
                        <i class="fas fa-hashtag input-icon"></i>
                        <input type="text" class="form-control input-with-icon"
                               name="isbn" value="${book.isbn}"
                               placeholder="请输入ISBN号" required>
                    </div>
                    <p class="form-note">国际标准书号，通常为10位或13位数字，不可和其他书籍ISBN码相同</p>
                </div>

                <div class="form-row">
                    <label class="form-label">
                        <i class="fas fa-calendar-alt"></i> 出版年份
                    </label>
                    <div class="input-group-icon">
                        <i class="fas fa-calendar input-icon"></i>
                        <input type="number" class="form-control input-with-icon"
                               name="publishYear" value="${book.publishYear}"
                               placeholder="请输入出版年份">
                    </div>
                    <p class="form-note">例如: 2023</p>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> 保存
                    </button>
                    <a href="/library/books" class="btn btn-secondary">
                        <i class="fas fa-times"></i> 取消
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 简单的输入效果增强
    document.addEventListener('DOMContentLoaded', function() {
        const inputs = document.querySelectorAll('.form-control');

        inputs.forEach(input => {
            // 添加输入动画效果
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'translateY(-2px)';
            });

            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'none';
            });
        });
    });
</script>
</body>
</html>