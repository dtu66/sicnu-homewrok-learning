<%--
  Created by IntelliJ IDEA.
  User: void
  Date: 2024/12/25
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../common/include.jsp"/>
</head>
<body>
<jsp:include page="../common/admin/header.jsp"/>
<div class="container mt-5">
    <h2>学习内容完成最多的前 3 名用户</h2>
    <div id="most-study-users" class="row"></div>

    <h2 class="mt-5">最近学习内容的 3 位用户</h2>
    <div id="latest-study-users" class="row"></div>
</div>
<jsp:include page="../common/footer.jsp"/>
</body>
<script>
    $(document).ready(function () {
        // 获取学习内容完成最多的 3 位用户
        $.ajax({
            url: "${pageContext.request.contextPath}/api/user/admin/most-study",
            type: "GET",
            success: function (response) {
                response = JSON.parse(response);
                if (response.code === 200) {
                    const users = response.data;
                    let html = '';
                    // 清空
                    $('#most-study-users').html('');
                    users.forEach((user) => {
                        let imageUri = user.headImage ? user.headImage : '/profile/default.jpg';
                        let url = "${pageContext.request.contextPath}/image" + imageUri;
                        $.ajax({
                            url: url,
                            type: 'GET',
                            success: function (response) {
                                response = JSON.parse(response);
                                let base64 = response.data.base64;
                                html += '<div class="col-md-4 mb-4">' +
                                    '<div class="card">' +
                                    '<img src="' + base64 + '" class="card-img-top" alt="' + user.username + '" style="max-width: 100px; max-height: 100px; object-fit: cover;">' +
                                    '<div class="card-body">' +
                                    '<h5 class="card-title">用户名：' + user.username + '</h5>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>';
                                // 追加
                                $('#most-study-users').html(html);
                            }
                        });

                    });
                }
            }
        });

        // 获取最近学习内容的 3 位用户
        $.ajax({
            url: "${pageContext.request.contextPath}/api/user/admin/latest-study",
            type: "GET",
            success: function (response) {
                response = JSON.parse(response);
                if (response.code === 200) {
                    const users = response.data;
                    let html = '';
                    // 清空
                    $('#latest-study-users').html('');
                    users.forEach((user) => {
                        let imageUri = user.headImage ? user.headImage : '/profile/default.jpg';
                        let url = "${pageContext.request.contextPath}/image" + imageUri;
                        $.ajax({
                            url: url,
                            type: 'GET',
                            success: function (response) {
                                response = JSON.parse(response);
                                let base64 = response.data.base64;
                                html += '<div class="col-md-4 mb-4">' +
                                    '<div class="card">' +
                                    '<img src="' + base64 + '" class="card-img-top" alt="' + user.username + '" style="max-width: 100px; max-height: 100px; object-fit: cover;">' +
                                    '<div class="card-body">' +
                                    '<h5 class="card-title">用户名：' + user.username + '</h5>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>';
                                // 追加
                                $('#latest-study-users').html(html);
                            }
                        });
                    });
                }
            }
        });
    });
</script>
</html>
