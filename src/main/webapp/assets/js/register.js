// 简单的前端验证逻辑
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