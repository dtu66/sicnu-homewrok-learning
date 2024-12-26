<%--
  Created by IntelliJ IDEA.
  User: void
  Date: 2024/12/24
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录</title>
    <%@include file="../common/include.jsp" %>

</head>
<body class="bg-light">
<div class="container d-flex justify-content-center align-items-center min-vh-100">
    <div class="card p-4 shadow-sm" style="max-width: 400px; width: 100%;">
        <h2 class="text-center mb-4">管理员登录</h2>
        <form id="loginForm" onsubmit="return loginSubmit(event)">
            <div class="mb-3">
                <label for="username" class="form-label">用户名</label>
                <input type="text" id="username" name="username" class="form-control" placeholder="请输入用户名" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">密码</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="请输入密码" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">登录</button>
            <div class="text-danger mt-3" id="errorMessage" style="display: none;"></div>
        </form>
        <div class="mt-3 text-center">
            <p>忘记密码请联系系统管理人员</p>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />

<script>
    function loginSubmit(event) {
        event.preventDefault(); // 防止表单默认提交

        var username = document.getElementById('username').value;
        var password = document.getElementById('password').value;

        $.ajax({
            url: "${pageContext.request.contextPath}/api/user/admin/login",
            type: 'POST',
            data: {
                username: username,
                password: password
            },
            success: function (data) {
                data = JSON.parse(data);
                if (data.message === 'success') {
                    window.location.href = "index";
                } else {
                    document.getElementById('errorMessage').innerText = "用户名或密码错误";
                    document.getElementById('errorMessage').style.display = "block";
                }
            },
            error: function (error) {
                document.getElementById('errorMessage').innerText = "服务器错误，请稍后再试";
                document.getElementById('errorMessage').style.display = "block";
            }
        });
    }
</script>

</body>
</html>
