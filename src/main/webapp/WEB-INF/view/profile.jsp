<%--
  Created by IntelliJ IDEA.
  User: void
  Date: 2024/12/25
  Time: 9:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人资料</title>
    <jsp:include page="./common/include.jsp"/>
</head>
<body>
<%@ include file="./common/user/header.jsp" %>


<div class="container mt-5">
    <h2 class="text-center mb-4">个人资料</h2>

    <!-- 个人资料表单 -->
    <div class="row">
        <div class="col-md-4">
            <img id="userImage1" src="${pageContext.request.contextPath}/image/profile/default.jpg" alt="头像" class="img-fluid rounded-circle" style="width: 150px; height: 150px; object-fit: cover;">
            <input type="file" id="headImageInput" class="form-control mt-2" />
        </div>
        <div class="col-md-8">
            <form id="profileForm">
                <div class="mb-3">
                    <label for="username" class="form-label">用户名</label>
                    <input type="text" id="username" class="form-control" value="" />
                </div>
                <div class="mb-3">
                    <label for="stuId" class="form-label">学号</label>
                    <input type="text" id="stuId" class="form-control" value="" disabled />
                </div>
                <button type="submit" class="btn btn-primary">保存修改</button>
            </form>

            <!-- 密码修改链接 -->
            <div class="mt-3">
                <a href="javascript:void(0);" id="changePasswordLink" class="text-primary">修改密码</a>
            </div>
        </div>
    </div>
</div>

<!-- 密码修改模态框 -->
<div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="changePasswordModalLabel">修改密码</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="changePasswordForm">
                    <div class="mb-3">
                        <label for="oldPassword" class="form-label">旧密码</label>
                        <input type="password" id="oldPassword" class="form-control" placeholder="请输入旧密码" required />
                    </div>
                    <div class="mb-3">
                        <label for="newPassword" class="form-label">新密码</label>
                        <input type="password" id="newPassword" class="form-control" placeholder="请输入新密码" required />
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">确认密码</label>
                        <input type="password" id="confirmPassword" class="form-control" placeholder="请确认新密码" required />
                    </div>
                    <button type="submit" class="btn btn-primary">提交</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="./common/footer.jsp" %>
</body>

<script>

    $(document).ready(function() {
        let user = JSON.parse(localStorage.getItem('user'));

        $('#userImage1').attr('src', "${pageContext.request.contextPath}/image"+user.headImage);
        $('#username').val(user.username);
        $('#stuId').val(user.stu20211108936);

        function loadImage(url) {
            $.ajax({
                url: url,
                type: 'GET',
                success: function(response) {
                    response = JSON.parse(response);
                    let base64 = response.data.base64;
                    console.log(base64);
                    // 渲染到#userImage
                    $('#userImage1').attr('src', base64);
                }
            })
        }
        let imageUri = user.headImage ? '/profile/'+$('#username').val() : '/profile/default.jpg';
        loadImage("${pageContext.request.contextPath}/image"+imageUri);


        // 表单提交事件
        $('#profileForm').on('submit', function(e) {
            e.preventDefault();
            var headImage = $('#headImageInput')[0].files[0];
            if (headImage) {
                var reader = new FileReader();
                reader.onload = () => {
                    console.log(reader.result);
                    var base64Image = reader.result;
                    $.ajax({
                        url: '${pageContext.request.contextPath}/image/upload',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({ base64: base64Image, path: '/profile/'+user.username }),
                        success: function(response) {
                            response = JSON.parse(response);
                            if (response.code === 200) {
                                headImage = response.data.url;
                            } else {
                                headImage = null;
                                alert("头像上传失败，请稍后再试.");
                            }
                        },
                        error: function() {
                            headImage = null;
                            alert("服务器错误，请稍后再试.");
                        }
                    })
                }
            }
            reader.readAsDataURL($('#headImageInput')[0].files[0]);
            $.ajax({
                url: "${pageContext.request.contextPath}/api/user",
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify({
                    id: user.id,
                    username: $('#username').val(),
                    stu20211108936: $('#stuId').val(),
                    headImage: imageUri
                }),
                success: function(response) {
                    response = JSON.parse(response);
                    if (response.code === 200) {
                        alert("个人资料更新成功!");
                        // 更新头像
                        if (headImage) {
                            loadImage("${pageContext.request.contextPath}/image"+response.data.headImage);
                        }
                    } else {
                        alert("更新失败，请稍后再试.");
                    }
                },
                error: function() {
                    alert("服务器错误，请稍后再试.");
                }
            });
        });

        // 头像文件选择事件
        $('#headImageInput').on('change', function() {
            var reader = new FileReader();
            reader.onload = function(e) {
                $('#userImage1').attr('src', e.target.result);
            };
            reader.readAsDataURL(this.files[0]);
        });

        // 点击修改密码链接时，显示密码修改模态框
        $('#changePasswordLink').on('click', function() {
            $('#changePasswordModal').modal('show');
        });

        // 密码修改表单提交事件
        $('#changePasswordForm').on('submit', function(e) {
            e.preventDefault();

            var oldPassword = $('#oldPassword').val();
            var newPassword = $('#newPassword').val();
            var confirmPassword = $('#confirmPassword').val();

            if (newPassword !== confirmPassword) {
                alert("新密码和确认密码不一致！");
                return;
            }

            $.ajax({
                url: "${pageContext.request.contextPath}/api/user/password",
                type: 'POST',
                data: {
                    id: <%= user.getId() %>,
                    oldPassword: oldPassword,
                    newPassword: newPassword
                },
                success: function(response) {
                    response = JSON.parse(response);
                    if (response.code === 200) {
                        alert("密码修改成功!");
                        $('#changePasswordModal').modal('hide');
                    } else {
                        alert("密码修改失败，请检查旧密码或稍后再试.");
                    }
                },
                error: function() {
                    alert("服务器错误，请稍后再试.");
                }
            });
        });
    });
</script>

</html>
