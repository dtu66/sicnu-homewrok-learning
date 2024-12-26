<%--
  Created by IntelliJ IDEA.
  User: void
  Date: 2024/12/25
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>

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

    $(document).ready(function() {
        // 检查用户是否登录
        $.ajax({
            url: "${pageContext.request.contextPath}/api/user/is-login",  // 后端接口
            type: "GET",
            success: function(response) {
                response = JSON.parse(response);
                if (response.code === 200) {
                    // 如果已登录，显示用户信息
                    var user = response.data;
                    $('#userMenu').show();  // 显示用户菜单
                    $('#username').text(user.username);  // 设置用户名
                    let imageUri = user.headImage ? user.headImage : '/profile/default.jpg';
                    loadImage("${pageContext.request.contextPath}/image"+imageUri);

                    // 隐藏登录按钮
                    $('#loginBtn').hide();
                } else {
                    window.location.href = "${pageContext.request.contextPath}/admin/login";  // 未登录，跳转到登录页面
                }
            },
            error: function() {
                // 如果请求失败，跳转到登录页面
                window.location.href = "${pageContext.request.contextPath}/admin/login";
            }
        });
    });
</script>
<header class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <!-- 网站Logo或标题 -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">管理员面板</a>

        <!-- 导航菜单 -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <!-- 首页链接 -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/index">首页</a>
                </li>

                <!-- 学习记录链接 -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/records">学习记录</a>
                </li>

                <!-- 用户管理链接 -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/user">用户管理</a>
                </li>

                <!-- 教程管理链接 -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/content">课程管理</a>
                </li>

                <!-- 管理员头像和下拉菜单 -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="" alt="头像" id="userImage" class="rounded-circle" style="width: 30px; height: 30px; object-fit: cover;">

                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
<%--                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/profile">个人资料</a></li>--%>
<%--                        <li><hr class="dropdown-divider"></li>--%>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout" onclick="localStorage.clear()">退出</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</header>

