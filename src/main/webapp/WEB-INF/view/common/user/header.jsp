<%@ page import="learn.qm20211108909636.app.entity.Userinfo" %><%--
  Created by IntelliJ IDEA.
  User: void
  Date: 2024/12/24
  Time: 21:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% Userinfo user = (Userinfo) session.getAttribute("user") ;%>
<script>
    let user = JSON.parse(localStorage.getItem("user"));
    function loadImage(url) {
        $.ajax({
            url: url,
            type: 'GET',
            success: function(response) {
                response = JSON.parse(response);
                let base64 = response.data.base64;
                // 渲染到#userImage
                $('#userImage').attr('src', base64);
            }
        })
    }
    let imageUri = user.headImage ? user.headImage : '/profile/default.jpg';
    loadImage("${pageContext.request.contextPath}/image"+imageUri);

    $.ajax({
        url: "${pageContext.request.contextPath}/api/user/is-login",
        type: "GET",
        success: function (data) {
            data = JSON.parse(data);
            if (data.code === 200) {
                console.log("login");
                localStorage.setItem("user", JSON.stringify(data.data));
            }else {
                console.log("logout");
                localStorage.clear();
            }
        }
    })
</script>
<header class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <!-- 网站Logo或标题 -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">校规学习</a>

        <!-- 导航菜单 -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <!-- 未登录时显示登录/注册按钮 -->
                <% if (user == null) { %>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/login">登录</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/register">注册</a>
                </li>
                <% } %>

                <!-- 登录后显示头像、用户名和下拉退出按钮 -->
                <% if (user != null) { %>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="<%= user.getHeadImage() %>" id="userImage" alt="头像" class="rounded-circle" style="width: 30px; height: 30px; object-fit: cover;">
                        <%= user.getUsername() %>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">个人资料</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout" onclick="localStorage.clear()">退出</a></li>
                    </ul>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</header>

