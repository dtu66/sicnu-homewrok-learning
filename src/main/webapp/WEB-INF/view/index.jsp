<%--
  Created by IntelliJ IDEA.
  User: void
  Date: 2024/12/24
  Time: 9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>校规学习</title>
    <%@include file="./common/include.jsp" %>

  </head>
  <body>
  <jsp:include page="./common/user/header.jsp" />

  <div class="container mt-4">

    <div class="card p-4 shadow-sm mb-4" style="max-width: 600px; width: 100%;" id="courseCard">
      <h2 class="text-center mb-4">课程信息</h2>

      <!-- 显示课程总数、已学课程数、未学课程数 -->
      <div id="courseInfo">
        <div class="mb-3">
          <h5 class="card-title">当前系统共有课程：<span id="totalCourses">0</span>节</h5>
        </div>
        <div class="mb-3" id="learnedCoursesDiv" style="display: none;">
          <h5 class="card-title">您已学习课程：<span id="learnedCourses">0</span>节</h5>
        </div>
        <div class="mb-3" id="remainingCoursesDiv" style="display: none;">
          <h5 class="card-title">剩余课程：<span id="remainingCourses">0</span>节</h5>
        </div>
      </div>

    </div>
<%--    <h1 class="text-center mb-4">学习内容</h1>--%>

    <!-- 搜索框 -->
    <div class="row mb-4">
      <div class="col-md-3">
        <input type="text" id="chapterId" class="form-control" placeholder="章节 ID">
      </div>
      <div class="col-md-3">
        <input type="text" id="chapterTitle" class="form-control" placeholder="章节标题">
      </div>
      <div class="col-md-3">
        <input type="text" id="chapterText" class="form-control" placeholder="章节内容">
      </div>
      <div class="col-md-3">
        <button class="btn btn-primary w-100" id="searchButton">搜索</button>
      </div>
    </div>

    <div id="contentList">
      <!-- 内容列表 -->
      <table class="table" style="border: none; width: 100%;">
        <thead>
        <tr>
          <th style="text-align: left; vertical-align: middle; width: 20%;">章节</th>
          <th style="text-align: left; vertical-align: middle; width: 50%;">章节标题</th>
          <th style="text-align: left; vertical-align: middle; width: 10%;" id="studyStatusColumn">学习情况</th>
          <th style="text-align: left; vertical-align: middle; width: 20%;"></th>
        </tr>
        </thead>
        <tbody id="contentBody">
        </tbody>
      </table>
    </div>

    <div class="d-flex justify-content-center mt-4">
      <nav aria-label="Page navigation example">
        <ul class="pagination" id="pagination">
          <!-- 分页按钮 -->
        </ul>
      </nav>
    </div>
  </div>

  <jsp:include page="common/footer.jsp" />
  </body>
  <script>
    let contentList=null;
    let LogList=null;
    $(document).ready(function() {
      var currentPage = 1;
      var pageSize = 10;
      var user = JSON.parse(localStorage.getItem('user')); // 获取登录用户信息

      // 搜索数据对象
      var searchData = {
        chapterTitle: '',
        chapterText: ''
      };

      // 获取课程信息（总数、已学、剩余）
      function getCourseInfo(userId) {
        if (userId === -1) {
          return;
        }
        $.ajax({
          url: "${pageContext.request.contextPath}/api/log/user/" + userId, // 获取用户学习日志的接口
          type: "GET",
          success: function (logData) {
            logData = JSON.parse(logData);
            LogList = logData.data;
            if (logData.code === 200) {
              const studiedIdSet = new Set(logData.data.studiedId); // 已学课程ID集合
              const totalCourses = studiedIdSet.size; // 已学课程数
              const totalCoursesFromContent = contentList.total; // 总课程数
              const remainingCourses = totalCoursesFromContent - totalCourses; // 剩余课程数

              // 更新页面内容
              $('#totalCourses').text(totalCoursesFromContent);
              $('#learnedCourses').text(totalCourses);
              $('#remainingCourses').text(remainingCourses);

              // 显示已学课程数和剩余课程数
              $('#learnedCoursesDiv').show();
              $('#remainingCoursesDiv').show();

              // 加载章节内容并判断学习情况
              loadContent(currentPage);
            } else {
              alert("获取学习日志失败！");
            }
          }
        });
      }

      // 加载内容并渲染学习状态
      function loadContent(page) {
        let studiedIdSet = LogList == null ? new Set() : new Set(LogList.studiedId);
        $.ajax({
          url: "${pageContext.request.contextPath}/api/content/search",
          type: 'POST',
          contentType: 'application/json',  // 设置请求头为 JSON 格式
          data: JSON.stringify({
            page: page,
            size: pageSize,
            chapterId: searchData.chapterId,
            chapterTitle: searchData.chapterTitle,
            chapterText: searchData.chapterText
          }),
          success: function(response) {
            response = JSON.parse(response);
            contentList = response.data;
            if (response.data.contents && response.data.total > 0) {
              var contentHtml = '';
              response.data.contents.forEach(function(content) {
                // 判断学习状态
                var studyStatus = studiedIdSet.has(content.id) ? '已学习' : '未学习';
                var studyStatusColumnClass = user ? '' : 'd-none'; // 如果未登录则隐藏学习情况列

                contentHtml +=
                        "<tr style='vertical-align: middle;'>" +
                        "<td style='text-align: left;'>第" + content.chapterId + "章</td>" +
                        "<td style='text-align: left;'>" + content.chapterTitle + "</td>" +
                        "<td style='text-align: left;' class='" + studyStatusColumnClass  + "'>" + studyStatus + "</td>" +
                        "<td style='text-align: left; padding-bottom: 10px;'><a href='${pageContext.request.contextPath}/content/" + content.id + "' class='btn btn-primary'>开始学习</a></td>" +
                        "</tr>";
              });
              $('#contentBody').html(contentHtml);

              // 更新分页
              var totalPages = Math.ceil(response.data.total / pageSize);
              var paginationHtml = '';
              for (var i = 1; i <= totalPages; i++) {
                paginationHtml += "<li class='page-item" + (i === page ? 'active' : '') + "'>" +
                        "<a class='page-link' href='javascript:void(0);' data-page='" + i + "'>" + i + "</a>" +
                        "</li>";
              }
              $('#pagination').html(paginationHtml);
            } else {
              $('#contentList').html('<p>没有更多内容了</p>');
            }
          },
          error: function() {
            $('#contentList').html('<p>加载失败，请稍后再试。</p>');
          }
        });
      }

      // 搜索按钮点击事件
      $('#searchButton').click(function() {
        // 获取搜索框中的值
        searchData.chapterId = $('#chapterId').val();
        searchData.chapterTitle = $('#chapterTitle').val();
        searchData.chapterText = $('#chapterText').val();

        // 清空分页并重新加载第一页内容
        currentPage = 1;
        loadContent(currentPage); // 初次加载内容时不传已学课程ID
      });

      // 使用事件委托绑定分页按钮的点击事件
      $(document).on('click', '.page-link', function() {
        var page = $(this).data('page');
        loadContent(page); // 更新分页时，不传已学课程ID
      });

      // 初始加载第一页内容
      loadContent(currentPage);
      // 如果用户已登录，显示学习状态，否则隐藏
      if (user) {
        $('#courseCard').show(); // 显示课程信息卡片
        getCourseInfo(user.id); // 获取课程信息并加载学习情况
      } else {
        $('#courseCard').hide(); // 隐藏课程信息卡片
        getCourseInfo(-1); // 获取课程信息并加载学习情况
      }
    });
  </script>


</html>
