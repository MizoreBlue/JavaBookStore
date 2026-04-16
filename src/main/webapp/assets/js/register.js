// 简单的前端验证逻辑
import addUser from '../../api/user.js';
function validateForm() {
    var username = document.forms["registerForm"]["username"].value;
    var password = document.forms["registerForm"]["password"].value;
    var email = document.forms["registerForm"]["email"].value;

    // 用户名验证：字母数字下划线1到10位，不能是数字开头
    var usernameRegex = /^[a-zA-Z_][a-zA-Z0-9_]{0,9}$/;
    if (!usernameRegex.test(username)) {
        alert("用户名必须是字母、数字或下划线，1-10位，且不能以数字开头！");
        return false;
    }

    // 密码验证：6-16位
    if (password.length < 6 || password.length > 16) {
        alert("密码长度必须在6到16位之间！");
        return false;
    }

    // 简单邮箱验证
    if(email.indexOf('@') === -1) {
        alert("请输入有效的邮箱地址！");
        return false;
    }

    return true;
}

function submitRegister() {
    // 1. 获取表单数据
    const form = document.getElementById('registerForm');
    const formData = new FormData(form);

    // 2. 发送 AJAX 请求 (模拟 Spring Boot 的前端行为)
    addUser(formData);


    fetch('${pageContext.request.contextPath}/user/register', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json()) // 将后端返回的流转为 JSON 对象
        .then(data => {
            // 3. 处理统一返回结果 Result<T>
            if (data.code === 1) {
                // 成功
                alert(data.msg); // 提示 "注册成功"
                // 跳转登录页
                window.location.href = '${pageContext.request.contextPath}/user/login';
            } else {
                // 失败
                alert(data.msg); // 提示错误信息
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('系统繁忙，请稍后再试');
        });
}