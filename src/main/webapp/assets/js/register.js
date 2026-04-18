// 简单的前端验证逻辑
function validateForm() {
    // 修正：HTML 中 name="telephone"，所以这里也要取 telephone
    var username = document.forms["registerForm"]["username"].value;
    var password = document.forms["registerForm"]["password"].value;
    var telephone = document.forms["registerForm"]["telephone"].value;

    // 用户名验证
    var usernameRegex = /^[a-zA-Z_][a-zA-Z0-9_]{0,9}$/;
    if (!usernameRegex.test(username)) {
        alert("用户名必须是字母、数字或下划线，1-10位，且不能以数字开头！");
        return false; // 返回 false 阻止表单提交
    }

    // 密码验证
    if (password.length < 6 || password.length > 16) {
        alert("密码长度必须在6到16位之间！");
        return false;
    }

    // 手机号验证 (如果是必填)
    if (telephone.length !== 11) {
        alert("请输入正确的11位手机号！");
        return false;
    }

    // 验证通过，执行 AJAX 提交
    submitRegister();

    // 返回 false，阻止表单的默认同步提交（即阻止页面刷新）
    return false;
}

function submitRegister() {
    const form = document.getElementById('registerForm');
    // 使用 URLSearchParams 构造表单数据
    const formData = new URLSearchParams(new FormData(form));

    fetch("/user/register", {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: formData.toString()
    })
        .then(response => {
            if (!response.ok) throw new Error("网络响应错误");
            return response.json();
        })
        .then(data => {
            // 根据截图，后端返回的消息在 data.msg 或 data.data 中
            // 你的截图显示: {"code":1, "msg":null, "data":"注册成功，请登录"}
            // 所以这里应该取 data.data

            if (data.code === 1) {
                alert(data.data || "注册成功！");
                // 注册成功 -> 跳转到登录页
                window.location.href = "login";
            } else {
                alert(data.data || "注册失败");
                // 注册失败 -> 刷新当前页或留在注册页
                // window.location.href = "register"; // 可选
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("系统错误，请查看控制台");
        });
}