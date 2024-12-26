<%--
  Created by IntelliJ IDEA.
  User: void
  Date: 2024/12/25
  Time: 16:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户管理</title>
    <jsp:include page="../common/include.jsp"/>
</head>
<body>
<jsp:include page="../common/admin/header.jsp"/>

<div class="container mt-4">
    <h2>用户管理</h2>

    <!-- 搜索框 -->
    <div class="row mb-3">
        <div class="col-md-3">
            <input type="text" id="username" class="form-control" placeholder="用户名" onkeyup="searchUserByPage()">
        </div>
        <div class="col-md-3">
            <select id="role" class="form-control" onchange="searchUserByPage()">
                <option value="">角色</option>
                <option value="admin">管理员</option>
                <option value="user">普通用户</option>
                <option value="hacker">黑客</option>
            </select>
        </div>
        <div class="col-md-3">
            <button class="btn btn-primary" onclick="searchUserByPage()">搜索</button>
        </div>
    </div>

    <!-- 用户列表表格 -->
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>用户名</th>
            <th>角色</th>
            <th>头像</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="userTableBody">
        <!-- 用户数据会在这里填充 -->
        </tbody>
    </table>

    <!-- 分页 -->
    <div id="pagination" class="mt-3">
        <button class="btn btn-primary" onclick="changePage(-1)">上一页</button>
        <span id="pageInfo">第 <span id="currentPage">1</span> 页，共 <span id="totalPage">1</span> 页</span>
        <button class="btn btn-primary" onclick="changePage(1)">下一页</button>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
</body>
<script>
    let users = [];
    let page = 1;
    let pageSize = 10;
    let total = 0;
    let searchData = {
        username: "",
        role: ""
    };

    // 搜索用户，分页查询
    function searchUserByPage() {
        // 获取用户输入的用户名和角色
        searchData.username = $("#username").val();
        searchData.role = $("#role").val();

        $.ajax({
            url: "${pageContext.request.contextPath}/api/user/admin/search",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                page: page,
                size: pageSize,
                username: searchData.username,
                role: searchData.role
            }),
            success: function (response) {
                response = JSON.parse(response);
                if (response.code === 200) {
                    users = response.data.list;
                    total = response.data.total;
                    renderUserTable();
                    updatePagination();
                } else {
                    alert("获取用户列表失败！");
                }
            },
            error: function () {
                alert("获取用户列表失败！");
            }
        });
    }

    // 渲染用户表格
    function renderUserTable() {
        let tbody = $("#userTableBody");
        tbody.empty();

        if (users.length === 0) {
            tbody.append("<tr><td colspan='4'>没有找到用户</td></tr>");
        } else {
            users.forEach(user => {
                let imageUri = user.headImage ? user.headImage : '/profile/default.jpg';
                let url = "${pageContext.request.contextPath}/image" + imageUri;
                $.ajax({
                    url: url,
                    type: 'GET',
                    success: function(response) {
                        response = JSON.parse(response);
                        let base64 =  response.data.base64;
                        let row = '<tr>' +
                            '<td>' + user.username + '</td>' +
                            '<td>' +
                            '<select class="form-control" onchange="updateUserRole(' + user.id + ', this)">' +
                            '<option value="admin"' + (user.role === 'admin' ? ' selected' : '') + '>管理员</option>' +
                            '<option value="user"' + (user.role === 'user' ? ' selected' : '') + '>普通用户</option>' +
                            '<option value="hacker"' + (user.role === 'hacker' ? ' selected' : '') + '>黑客</option>' +
                            '</select>' +
                            '</td>' +
                            '<td>' +
                            // 控制图片大小，避免超出单元格
                            '<img src="' + base64 + '" alt="头像" class="img-thumbnail" style="max-width: 50px; max-height: 50px;"/>' +
                            '<button class="btn btn-danger btn-sm ml-2" onclick="deleteAvatar(' + user.id + ')">删除头像</button>' +
                            '</td>' +
                            '<td>' +
                            '<button class="btn btn-danger btn-sm" onclick="deleteUser(' + user.id + ')">删除用户</button>' +
                            '</td>' +
                            '</tr>';
                        tbody.append(row);
                    }
                })

            });
        }
    }

    // 更新用户角色
    function updateUserRole(userId, selectElement) {
        const newRole = selectElement.value;
        $.ajax({
            url: `${pageContext.request.contextPath}/api/user/admin/user/role`,
            type: "PUT",
            contentType: "application/json",
            data: JSON.stringify({
                id: userId,
                role: newRole
            }),
            success: function (response) {
                response = JSON.parse(response);
                if (response.code === 200) {
                    alert("角色更新成功！");
                    searchUserByPage();  // 刷新列表
                } else {
                    alert("修改失败！");
                }
            },
            error: function () {
                alert("修改失败！");
            }
        });
    }

    // 删除用户头像
    function deleteAvatar(userId) {
        $.ajax({
            url: `${pageContext.request.contextPath}/api/user/admin/user/avatar`,
            type: "DELETE",
            contentType: "application/json",
            data: JSON.stringify({
                id: userId
            }),
            success: function (response) {
                response = JSON.parse(response);
                if (response.code === 200) {
                    alert("头像删除成功！");
                    searchUserByPage();  // 刷新列表
                } else {
                    alert("删除失败！");
                }
            },
            error: function () {
                alert("删除失败！");
            }
        });
    }

    // 删除用户
    function deleteUser(userId) {
        $.ajax({
            url: `${pageContext.request.contextPath}/api/user/admin/user`,
            type: "DELETE",
            contentType: "application/json",
            data: JSON.stringify({
                id: userId
            }),
            success: function (response) {
                response = JSON.parse(response);
                if (response.code === 200) {
                    alert("用户删除成功！");
                    searchUserByPage();  // 刷新列表
                } else {
                    alert("删除失败！");
                }
            },
            error: function () {
                alert("删除失败！");
            }
        });
    }

    // 更新分页信息
    function updatePagination() {
        const totalPage = Math.ceil(total / pageSize);
        $("#currentPage").text(page);
        $("#totalPage").text(totalPage);
    }

    // 翻页操作
    function changePage(direction) {
        const newPage = page + direction;
        if (newPage >= 1 && newPage <= Math.ceil(total / pageSize)) {
            page = newPage;
            searchUserByPage();
        }
    }

    $(document).ready(function () {
        searchUserByPage();
    });
</script>
</html>
