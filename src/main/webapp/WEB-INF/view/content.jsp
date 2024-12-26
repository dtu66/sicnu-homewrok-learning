<%--
  Created by IntelliJ IDEA.
  User: void
  Date: 2024/12/25
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="./common/include.jsp"/>
    <style>
        .chapter-content {
            margin-top: 30px;
        }
    </style>
</head>
<body>
<jsp:include page="./common/user/header.jsp"/>

<div class="container">
    <div class="chapter-content">
        <div class="card">
            <div class="card-header">
                <h2 id="chapterTitle">Loading...</h2>
            </div>
            <div class="card-body">
                <div>
<%--                    <strong>Image:</strong>--%>
                    <img id="chapterImage" src="" alt="章节封面" class="img-fluid">
                </div>
                <p><strong>第<span id="chapterId">？</span>章</strong></p>
                <p><strong>点击数：<span id="hits">？</span></strong> </p>
                <div><strong>内容</strong></div>
                <p id="chapterText">Loading...</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="./common/footer.jsp"/>
</body>

<script>
    function loadImage(url) {
        $.ajax({
            url: url,
            type: 'GET',
            success: function(response) {
                response = JSON.parse(response);
                let base64 = response.data.base64;
                // 渲染到#userImage
                $('#chapterImage').attr('src', base64);
            }
        })
    }
    $(document).ready(function() {
        // 获取URL参数（ID）
        var contentId = <%=session.getAttribute("contentId")%>;
        $.ajax({
            url: '${pageContext.request.contextPath}/api/content/'+contentId,
            type: 'GET',
            success: function(response) {
                response = JSON.parse(response);
                console.log(response);
                if (response.code === 401){
                    alert("请先登录");
                    window.location.href = '${pageContext.request.contextPath}/login';
                }else if (response.code === 404){
                    alert("无权限");
                    window.location.href = '${pageContext.request.contextPath}/';
                }
                var data = response.data;
                // 填充数据到页面
                $('#chapterTitle').text(data.chapterTitle);
                $('#chapterId').text(data.chapterId);
                $('#hits').text(data.hits);
                $('#chapterText').html(data.chapterText);
                $('#chapterImage').attr('src', data.chapterImage);
                let imageUri = data.chapterImage ? data.chapterImage : '/cover/default.jpg';
                loadImage("${pageContext.request.contextPath}/image"+imageUri);

                // 如果章节内容较长，使用 Bootstrap 的 `text-break` 来保证长文本不会超出容器宽度
                $('#chapterText').addClass('text-break');
            },
            error: function() {
                alert("加载数据失败");
            }
        });
    });
</script>

</html>
