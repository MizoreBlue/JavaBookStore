<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 获取项目根路径，用于处理 CSS 或图片路径（如果有的话）
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

    <style>
        body {
            font-family: "Microsoft YaHei", Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 20px;
        }

        /* 主容器卡片风格 */
        .form-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: 0 auto;
            border: 1px solid #e8e8e8;
        }

        /* 顶部标题栏 */
        .form-header {
            background-color: #eef5fd; /* 淡蓝色背景 */
            color: #333;
            padding: 12px 20px;
            border-bottom: 1px solid #d6e9f8;
            font-size: 16px;
            font-weight: bold;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }

        /* 表格布局样式 */
        .form-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .form-table th {
            width: 100px;
            text-align: right;
            padding: 10px 15px;
            color: #555;
            font-weight: normal;
            background-color: #fbfbfb;
        }

        .form-table td {
            padding: 10px;
            text-align: left;
        }

        /* 输入框通用样式 */
        input[type="text"],
        input[type="number"],
        select,
        textarea {
            width: 250px;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        input[type="file"] {
            border: none;
            padding: 0;
            width: auto;
        }

        /* 输入框聚焦效果 */
        input:focus, select:focus, textarea:focus {
            border-color: #40a9ff;
            outline: none;
            box-shadow: 0 0 5px rgba(24, 144, 255, 0.2);
        }

        textarea {
            width: 450px; /* 描述框宽一点 */
            height: 80px;
            vertical-align: top;
            resize: vertical;
        }

        /* 按钮区域 */
        .form-footer {
            padding: 15px 20px;
            text-align: center;
            border-top: 1px solid #e8e8e8;
            background-color: #fafafa;
            border-bottom-left-radius: 8px;
            border-bottom-right-radius: 8px;
        }

        .btn {
            padding: 8px 25px;
            margin: 0 10px;
            border: 1px solid #d9d9d9;
            background-color: #fff;
            color: #333;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
        }

        .btn-primary {
            background-color: #1890ff;
            color: #fff;
            border-color: #1890ff;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .btn-primary:hover {
            background-color: #40a9ff;
            border-color: #40a9ff;
        }

        .btn-reset {
            background-color: #fff;
            color: #333;
        }
    </style>

<div class="form-container">
    <!-- 标题 -->
    <div class="form-header">
        添加商品
    </div>

    <!-- 表单开始 -->
    <!--
         action: 提交给 /backend/product/add
         method: POST
         enctype: 必须包含 multipart/form-data 才能上传图片
     -->
    <!-- 省略了上面的 CSS 样式部分，保持不变 -->

    <!-- 表单开始 -->
    <!-- 修改点：添加了 enctype="multipart/form-data" -->
    <form action="${pageContext.request.contextPath}/backend/product/add"
          method="post"
          enctype="multipart/form-data"
          id="addForm">

        <table class="form-table">
            <tr>
                <th>商品名称：</th>
                <td><input type="text" name="name" placeholder="请输入商品名称" required/></td>
                <th>商品价格：</th>
                <td><input type="number" step="0.01" name="price" placeholder="0.00" required/></td>
            </tr>
            <tr>
                <th>商品数量：</th>
                <td><input type="number" name="stock" placeholder="库存数量" required/></td>
                <th>商品类别：</th>
                <td>
                    <select name="category" required>
                        <option value="">--选择商品类别--</option>
                        <option value="计算机">计算机</option>
                        <option value="文学">文学</option>
                        <option value="生活">生活</option>
                        <option value="外语">外语</option>
                        <option value="少儿">少儿</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>商品图片：</th>
                <td><input type="file" name="image" accept="image/*" /></td>
                <td colspan="2"></td>
            </tr>
            <tr>
                <th>商品描述：</th>
                <td colspan="3">
                    <textarea name="description" placeholder="请输入商品的详细描述信息..."></textarea>
                </td>
            </tr>
        </table>

        <div class="form-footer">
            <button type="button" class="btn btn-primary" onclick="submitForm()">确定</button>
            <button type="reset" class="btn btn-reset">重置</button>
            <button type="button" class="btn" onclick="history.back()">返回</button>
        </div>
    </form>
</div>

<script>
    function submitForm() {
        // 获取表单元素
        var form = document.getElementById('addForm');

        // 使用 FormData 对象来收集表单数据（包括文件）
        var formData = new FormData(form);

        // 使用 fetch API 发送异步请求
        fetch(form.action, {
            method: 'POST',
            body: formData
        })
            .then(response => response.json()) // 将返回的数据解析为 JSON
            .then(result => {
                // result 就是你后端返回的 Result 对象 {code: 1, msg: "...", data: ...}

                if (result.code === 1) {
                    // 成功 (假设 code=1 代表成功)
                    alert("添加成功！");
                    const contextPath = "${pageContext.request.contextPath}";
                    window.location.href = contextPath + "/backend/product/list";
                } else {
                    // 失败
                    alert("添加失败：" + result.msg);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("系统异常，请查看控制台");
            });
    }
</script>
