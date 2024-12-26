<%--
  Created by IntelliJ IDEA.
  User: void
  Date: 2024/12/24
  Time: 18:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>注册</title>
  <%@include file="./common/include.jsp" %>

</head>
<body class="bg-light">

<div class="container d-flex justify-content-center align-items-center min-vh-100">
  <div class="card p-4 shadow-sm" style="max-width: 400px; width: 100%;">
    <h2 class="text-center mb-4">用户注册</h2>
    <form id="registerForm" onsubmit="return registerSubmit(event)">
      <div class="mb-3">
        <label for="username" class="form-label">用户名</label>
        <input type="text" id="username" name="username" class="form-control" placeholder="请输入用户名" required>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">密码</label>
        <input type="password" id="password" name="password" class="form-control" placeholder="请输入密码" required>
      </div>
      <button type="submit" class="btn btn-primary w-100">注册</button>
      <div class="text-danger mt-3" id="errorMessage" style="display: none;"></div>
    </form>
    <div class="mt-3 text-center">
      <p>已有账户？<a href="${pageContext.request.contextPath}/login" class="text-primary">登录</a></p>
    </div>
  </div>
</div>

<jsp:include page="common/footer.jsp" />

<script>
  function registerSubmit(event) {
    event.preventDefault(); // 防止表单默认提交

    var username = document.getElementById('username').value;
    var password = document.getElementById('password').value;

    // 简单的用户名和密码验证
    if (username.trim() === "" || password.trim() === "") {
      document.getElementById('errorMessage').innerText = "用户名和密码不能为空";
      document.getElementById('errorMessage').style.display = "block";
      return;
    }

    $.ajax({
      url: "${pageContext.request.contextPath}/api/user",
      type: 'POST',
      data: {
        username: username,
        password: password
      },
      success: function (data) {
        // 注册成功，跳转到登录页面或其他页面
        data = JSON.parse(data);
        if (data.message === 'success') {
          window.location.href = "${pageContext.request.contextPath}/login"; // 注册成功后跳转到登录页面
        } else {
          document.getElementById('errorMessage').innerText = "用户名已存在";
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
