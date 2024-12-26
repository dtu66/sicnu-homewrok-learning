<%--
  Created by IntelliJ IDEA.
  User: void
  Date: 2024/12/25
  Time: 16:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学习记录</title>
    <jsp:include page="../common/include.jsp"/>
</head>
<body>
<jsp:include page="../common/admin/header.jsp"/>

<!-- 查询框 -->
<div class="container mt-4">
    <div class="row">
        <div class="col-md-6">
            <input type="text" id="username" class="form-control" placeholder="输入用户名进行查询">
        </div>
        <div class="col-md-6">
            <button class="btn btn-primary" onclick="searchLogByPage(1)">查询</button>
        </div>
    </div>
</div>

<!-- 学习记录 -->
<div id="logRecords" class="container mt-4">
</div>

<!-- 分页 -->
<div id="pagination" class="container mt-4 text-center">
    <button class="btn btn-secondary" onclick="changePage(-1)" id="prevPageBtn" disabled>上一页</button>
    <span id="currentPage">第 1 页</span>
    <button class="btn btn-secondary" onclick="changePage(1)" id="nextPageBtn" disabled>下一页</button>
</div>

<jsp:include page="../common/footer.jsp"/>
</body>
<script>
    let page = 1;
    let pageSize = 10;
    let total = 0;
    let logData = [];
    let username = '';

    // 查询功能
    function searchLogByPage(pageNum) {
        page = pageNum;
        username = document.getElementById('username').value.trim();

        $.ajax({
            url: '${pageContext.request.contextPath}/api/log/admin/record/search',
            type: 'POST',
            contentType: "application/json",
            data: JSON.stringify({
                page: page,
                size: pageSize,
                username: username
            }),
            success: function (response) {
                response = JSON.parse(response);
                if (response.code === 200) {
                    logData = response.data.logs;
                    total = response.data.total;
                    updateLogRecords();
                    updatePagination();
                } else {
                    alert(response.message);
                }
            },
            error: function () {
                alert('获取学习记录失败');
            }
        });
    }

    // 更新学习记录
    function updateLogRecords() {
        let html = '';
        logData.forEach(function (user) {
            html += '<div class="card mb-3">' +
                '<div class="card-header">' +
                '<h5 class="mb-0">' +
                '<button class="btn btn-link" type="button" data-bs-toggle="collapse" data-bs-target="#logs_' + user.userId + '" aria-expanded="false" aria-controls="logs_' + user.userId + '">' +
                user.username +
                '</button>' +
                '</h5>' +
                '</div>' +
                '<div id="logs_' + user.userId + '" class="collapse">' +
                '<div class="card-body">' +
                '<ul class="list-group">';
            user.logs.forEach(function (log) {
                html += '<li class="list-group-item">' +
                    '<strong>第' + log.contentId + '章</strong> - 学习时间: ' + formatTime(log.opTime) +
                    '</li>';
            });
            html += '</ul>' +
                '</div>' +
                '</div>' +
                '</div>';
        });

        document.getElementById('logRecords').innerHTML = html;
    }

    // 更新分页
    function updatePagination() {
        const totalPages = Math.ceil(total / pageSize);
        document.getElementById('currentPage').textContent = '第 ' + page + ' 页 / 共 ' + totalPages + ' 页';

        // 上一页按钮
        if (page <= 1) {
            document.getElementById('prevPageBtn').disabled = true;
        } else {
            document.getElementById('prevPageBtn').disabled = false;
        }

        // 下一页按钮
        if (page >= totalPages) {
            document.getElementById('nextPageBtn').disabled = true;
        } else {
            document.getElementById('nextPageBtn').disabled = false;
        }
    }

    // 切换分页
    function changePage(direction) {
        const totalPages = Math.ceil(total / pageSize);
        let newPage = page + direction;

        if (newPage >= 1 && newPage <= totalPages) {
            page = newPage;
            searchLogByPage(page);
        }
    }

    // 格式化时间
    function formatTime(timeStr) {
        const date = new Date();
        const options = { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit' };
        // return date.toLocaleDateString('zh-CN', options);
        // 直接返回系统时间
        return date.toLocaleString();
    }

    // 页面加载时默认查询第一页
    searchLogByPage(page);
</script>
</html>
