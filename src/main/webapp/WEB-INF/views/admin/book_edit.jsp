<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${empty book ? '新增图书' : '编辑图书'}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: "Microsoft YaHei", Arial, sans-serif; background: #ecf0f1; }
        .layout { display: flex; min-height: 100vh; }
        .sidebar { width: 220px; background: #2c3e50; color: white; padding: 20px 0; flex-shrink: 0; }
        .sidebar h2 { padding: 0 20px 20px; font-size: 18px; border-bottom: 1px solid #34495e; }
        .sidebar a { display: block; padding: 12px 25px; color: #bdc3c7; text-decoration: none; font-size: 14px; }
        .sidebar a:hover { background: #34495e; color: white; }
        .main { flex: 1; padding: 20px; display: flex; flex-direction: column; align-items: center; }
        .topbar { background: white; padding: 12px 20px; border-radius: 6px; margin-bottom: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); width: 100%; max-width: 800px; text-align: center; }
        .topbar h1 { font-size: 18px; color: #2c3e50; }
        .card { background: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); width: 100%; max-width: 800px; }
        .card h2 { font-size: 16px; color: #2c3e50; margin-bottom: 20px; border-left: 4px solid #3498db; padding-left: 10px; }
        form .form-row { margin-bottom: 18px; }
        label { display: block; margin-bottom: 6px; color: #555; font-size: 14px; font-weight: 500; }
        input[type="text"], input[type="number"], textarea, select {
            width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px;
            transition: border-color 0.2s;
        }
        input[type="text"]:focus, input[type="number"]:focus, textarea:focus, select:focus {
            border-color: #3498db; outline: none;
        }
        textarea { min-height: 100px; resize: vertical; }
        .btn-group { display: flex; justify-content: center; gap: 15px; margin-top: 25px; }
        .btn { padding: 10px 30px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 14px; display: inline-block; color: white; }
        .btn-primary { background: #3498db; }
        .btn-primary:hover { background: #2980b9; }
        .btn-default { background: #95a5a6; }
        .btn-default:hover { background: #7f8c8d; }
        .image-preview-wrapper { margin-top: 8px; }
        .image-preview-wrapper img {
            max-width: 200px; max-height: 280px; border: 1px solid #ddd; border-radius: 4px;
            object-fit: cover; display: ${empty book.image ? 'none' : 'block'};
        }
        .image-preview-wrapper .no-image {
            width: 200px; height: 140px; border: 2px dashed #ddd; border-radius: 4px;
            display: flex; align-items: center; justify-content: center; color: #999; font-size: 13px;
        }
        input[type="file"] { padding: 6px; border: 1px solid #ddd; border-radius: 4px; width: 100%; background: #fafafa; }

        @media (max-width: 768px) {
            .layout { flex-direction: column; }
            .sidebar { width: 100%; display: flex; flex-wrap: wrap; padding: 10px 0; }
            .sidebar h2 { width: 100%; padding: 0 15px 10px; }
            .sidebar a { padding: 8px 15px; font-size: 13px; }
            .main { padding: 15px; }
            .card { padding: 20px; }
            .btn-group { flex-direction: column; }
            .btn { width: 100%; text-align: center; }
        }
    </style>
</head>
<body>
    <div class="layout">
        <div class="sidebar">
            <h2>Java Book Store</h2>
            <a href="${pageContext.request.contextPath}/backend/home">控制台</a>
            <a href="${pageContext.request.contextPath}/backend/book">图书管理</a>
            <a href="${pageContext.request.contextPath}/backend/category">分类管理</a>
            <a href="${pageContext.request.contextPath}/backend/order">订单管理</a>
            <a href="${pageContext.request.contextPath}/backend/user">用户管理</a>
        </div>
        <div class="main">
            <div class="topbar"><h1>${empty book ? '新增图书' : '编辑图书'}</h1></div>
            <div class="card">
                <h2>图书信息</h2>
                <form action="${pageContext.request.contextPath}/backend/book" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="save">
                    <c:if test="${not empty book}"><input type="hidden" name="id" value="${book.id}"></c:if>
                    <div class="form-row">
                        <label>书名 *</label>
                        <input type="text" name="name" required value="${book.name}">
                    </div>
                    <div class="form-row">
                        <label>作者 *</label>
                        <input type="text" name="author" required value="${book.author}">
                    </div>
                    <div class="form-row">
                        <label>分类 *</label>
                        <select name="category" required>
                            <option value="">请选择分类</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.name}" ${book.category == cat.name ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-row">
                        <label>价格 *</label>
                        <input type="number" step="0.01" min="0" name="price" required value="${book.price}">
                    </div>
                    <div class="form-row">
                        <label>库存</label>
                        <input type="number" min="0" name="stock" value="${book.stock}">
                    </div>
                    <div class="form-row">
                        <label>封面图片</label>
                        <input type="file" name="imageFile" id="imageFile" accept="image/*">
                        <input type="hidden" name="oldImage" value="${book.image}">
                        <div class="image-preview-wrapper">
                            <img id="previewImg" src="${not empty book.image ? book.image : ''}" alt="封面预览">
                            <div id="noImageTip" class="no-image" style="display: ${empty book.image ? 'flex' : 'none'};">暂无封面图片</div>
                        </div>
                    </div>
                    <div class="form-row">
                        <label>简介</label>
                        <textarea name="description">${book.description}</textarea>
                    </div>
                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">保存</button>
                        <a href="${pageContext.request.contextPath}/backend/book" class="btn btn-default">返回</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script>
        var fileInput = document.getElementById('imageFile');
        var previewImg = document.getElementById('previewImg');
        var noImageTip = document.getElementById('noImageTip');
        fileInput.addEventListener('change', function() {
            var file = this.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    previewImg.style.display = 'block';
                    noImageTip.style.display = 'none';
                };
                reader.readAsDataURL(file);
            }
        });
    </script>
</body>
</html>
