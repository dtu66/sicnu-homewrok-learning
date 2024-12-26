<%--
  Created by IntelliJ IDEA.
  User: void
  Date: 2024/12/25
  Time: 20:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课程管理</title>
    <jsp:include page="../common/include.jsp"/>
</head>
<body>
<jsp:include page="../common/admin/header.jsp"/>
<div class="container mt-4">
    <!-- 搜索框 -->
    <div class="row mb-4">
        <div class="col-md-3">
            <input type="text" class="form-control" id="searchChapterTitle" placeholder="搜索章节标题">
        </div>
        <div class="col-md-3">
            <input type="text" class="form-control" id="searchChapterText" placeholder="搜索章节内容">
        </div>
        <div class="col-md-3">
            <button class="btn btn-primary" onclick="searchContent()">搜索</button>
        </div>
        <div class="col-md-3">
            <button class="btn btn-success" onclick="showAddModal()">新增章节</button>

        </div>
    </div>

    <h3>课程管理</h3>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>章节编号</th>
            <th>章节标题</th>
            <th>学习数</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="contentTableBody">
        <!-- 动态填充课程内容 -->
        </tbody>
    </table>
    <div id="pagination" class="d-flex justify-content-center mb-4">
        <!-- 分页按钮 -->
    </div>
</div>

<!-- 编辑课程内容弹窗 -->
<div class="modal fade" id="contentModal" tabindex="-1" aria-labelledby="contentModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="contentModalLabel">编辑课程内容</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="chapterTitle" class="form-label">章节标题</label>
                    <input type="text" class="form-control" id="chapterTitle">
                </div>
                <div class="mb-3">
                    <label for="chapterText" class="form-label">章节内容</label>
                    <textarea class="form-control" id="chapterText"></textarea>
                </div>
                <div class="mb-3">
                    <label for="chapterImage" class="form-label">封面图片</label>
                    <input type="file" class="form-control" id="chapterImage">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveContentBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 新增课程内容弹窗 -->
<div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addModalLabel">新增章节</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="addModalChapterId" class="form-label">章节编号</label>
                    <input type="text" class="form-control" id="addModalChapterId" placeholder="请输入章节编号" required>
                </div>
                <div class="mb-3">
                    <label for="addModalTitle" class="form-label">章节标题</label>
                    <input type="text" class="form-control" id="addModalTitle" placeholder="章节标题">
                </div>
                <div class="mb-3">
                    <label for="addModalText" class="form-label">章节内容</label>
                    <textarea class="form-control" id="addModalText" placeholder="章节内容"></textarea>
                </div>
                <div class="mb-3">
                    <label for="addModalImage" class="form-label">封面图片</label>
                    <input type="file" class="form-control" id="addModalImage">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="addContent()">保存</button>
            </div>
        </div>
    </div>
</div>


<!-- 查看课程内容弹窗 -->
<div class="modal fade" id="viewContentModal" tabindex="-1" aria-labelledby="viewContentModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="viewContentModalLabel">查看课程内容</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="viewChapterTitle" class="form-label">章节标题</label>
                    <input type="text" class="form-control" id="viewChapterTitle" readonly>
                </div>
                <div class="mb-3">
                    <label for="viewChapterText" class="form-label">章节内容</label>
                    <div class="form-control" id="viewChapterText"></div>
                </div>
                <div class="mb-3">
                    <label for="viewChapterImage" class="form-label">封面图片</label>
                    <img id="viewChapterImage" class="img-fluid" />
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
</body>
<script>
    let page = 1;
    let pageSize = 10;
    let total = 0;
    let contentData = [];

    // 用于存储富文本编辑器实例
    let editorInstance = null;

    function loadImage(item,url) {
        $.ajax({
            url: url,
            type: 'GET',
            success: function(response) {
                response = JSON.parse(response);
                let base64 = response.data.base64;
                // 渲染到#userImage
                $(item).attr('src', base64);
            }
        })
    }

    // 获取课程内容
    function getCourseInfo() {
        $.ajax({
            url: "${pageContext.request.contextPath}/api/content/search",
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                page: page,
                size: pageSize,
                chapterTitle: '',
                chapterText: ''
            }),
            success: function(response) {
                response = JSON.parse(response);
                if (response.code === 200) {
                    contentData = response.data.contents;
                    total = response.data.total;
                    renderTable();
                    renderPagination();
                } else {
                    alert('获取课程信息失败');
                }
            },
            error: function () {
                alert('获取课程信息失败');
            }
        });
    }

    // 渲染课程表格
    function renderTable() {
        let tableBody = $('#contentTableBody');
        tableBody.empty();
        contentData.forEach(function(content) {
            let row = '';
            row += '<tr>';
            row += '<td>' + content.chapterId + '</td>'; // 显示章节ID
            row += '<td>' + content.chapterTitle + '</td>';
            row += '<td>' + content.hits + '</td>';
            row += '<td>';
            row += '<button class="btn btn-primary btn-sm mb-1" onclick="viewContent(' + content.id + ')">查看</button>';
            row += '<button class="btn btn-primary btn-sm mb-1" onclick="editContent(' + content.id + ')">修改</button>';
            row += '<button class="btn btn-primary btn-sm mb-1" onclick="deleteContent(' + content.id + ')">删除</button>';
            row += '</td>';
            row += '</tr>';


            tableBody.append(row);
        });
    }

    // 渲染分页
    function renderPagination() {
        let pagination = $('#pagination');
        pagination.empty();
        let totalPages = Math.ceil(total / pageSize);
        for (let i = 1; i <= totalPages; i++) {
            let pageBtn = '';
            pageBtn += '<button class="btn btn-outline-primary btn-sm" onclick="changePage(' + i + ')">' + i + '</button>';
            pagination.append(pageBtn);
        }
    }

    // 切换分页
    function changePage(newPage) {
        if (newPage !== page) {
            page = newPage;
            getCourseInfo();
        }
    }

    // 搜索功能
    function searchContent() {
        searchData.chapterTitle = $('#searchChapterTitle').val();
        searchData.chapterText = $('#searchChapterText').val();
        currentPage = 1; // 重置为第一页
        getCourseInfo(); // 重新加载数据
    }

    function viewContent(id) {
        $.ajax({
            url: "${pageContext.request.contextPath}/api/content/admin/" + id,
            type: 'GET',
            success: function(response) {
                response = JSON.parse(response);
                if (response.code === 200) {
                    const content = response.data;

                    // 清空弹窗内容
                    $('#viewChapterTitle').val(content.chapterTitle);  // 章节标题
                    $('#viewChapterText').html(content.chapterText);    // 章节内容

                    // 设置封面图片
                    let imageUri = content.chapterImage ? content.chapterImage : '/cover/default.jpg';
                    loadImage($('#viewChapterImage'),"${pageContext.request.contextPath}/image"+imageUri);

                    // 展示查看课程内容的弹窗
                    $('#viewContentModal').modal('show');
                } else {
                    alert('获取内容失败');
                }
            }
        });
    }


    // 新增课程内容弹窗
    function showAddModal() {
        // 清空新增弹窗内容
        $('#addModalTitle').val('');
        $('#addModalText').val('');

        // 在打开新增弹窗时初始化富文本编辑器
        if (editorInstance) {
            // 如果编辑器已经存在，销毁它
            editorInstance.destroy().then(() => {
                editorInstance = null;  // 清除实例
            }).catch(error => {
                console.error("销毁编辑器失败", error);
            });
        }

        // 创建新的富文本编辑器实例
        ClassicEditor.create(document.querySelector('#addModalText')).then(editor => {
            editorInstance = editor;  // 保存编辑器实例
        }).catch(error => {
            console.error("初始化编辑器失败", error);
        });

        // 显示新增弹窗
        $('#addModal').modal('show');
    }

    // 新增课程内容
    function addContent() {
        // 获取新增课程内容的数据
        var chapterId = $('#addModalChapterId').val();  // 获取章节编号
        var title = $('#addModalTitle').val();
        var text = $('#addModalText').val();

        // 获取富文本内容
        var editorContent = editorInstance ? editorInstance.getData() : ''; // 获取编辑器内容

        var data = {
            chapterId: chapterId,  // 章节编号
            chapterTitle: title,
            chapterText: editorContent,  // 使用富文本内容

        };

        // 提交到后台保存新增课程内容
        $.ajax({
            url: "${pageContext.request.contextPath}/api/content/admin/add",
            type: 'POST',
            data: JSON.stringify(data),
            contentType: 'application/json',
            success: function(response) {
                response = JSON.parse(response);
                if (response.code === 200) {
                    alert('新增成功');
                    $('#addModal').modal('hide');
                    getCourseInfo();  // 刷新课程列表
                } else {
                    alert('新增失败');
                }
            },
            error: function() {
                alert('请求失败');
            }
        });
    }


    // 编辑课程内容
    function editContent(id) {
        $.ajax({
            url: "${pageContext.request.contextPath}/api/content/admin/" + id,
            type: 'GET',
            success: function(response) {
                response = JSON.parse(response);
                if (response.code === 200) {
                    let content = response.data;
                    $('#chapterTitle').val(content.chapterTitle);
                    $('#chapterText').val(content.chapterText);

                    // 如果编辑器实例已经存在，先销毁它
                    if (editorInstance) {
                        editorInstance.destroy()
                            .then(() => {
                                console.log("编辑器实例已销毁");
                            })
                            .catch(error => {
                                console.error("销毁编辑器失败", error);
                            });
                    }

                    // 创建新的富文本编辑器实例
                    ClassicEditor.create(document.querySelector('#chapterText'))
                        .then(editor => {
                            editorInstance = editor; // 保存编辑器实例
                            editor.setData(content.chapterText);
                        })
                        .catch(error => {
                            console.error("初始化编辑器失败", error);
                        });

                    $('#contentModal').modal('show');
                    $('#saveContentBtn').off('click').on('click', function() {
                        updateContent(id);
                    });
                } else {
                    alert('获取课程内容失败');
                }
            }
        });
    }

    // 保存修改后的课程内容
    function updateContent(id) {
        let chapterImage = $('#chapterImage')[0].files[0];

        if (chapterImage) {
            var reader = new FileReader();
            reader.onload = () => {
                var base64Image = reader.result;
                $.ajax({
                    url: '${pageContext.request.contextPath}/image/upload',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ base64: base64Image, path: '/cover/'+id }),
                    success: function(response) {
                        response = JSON.parse(response);
                        if (response.code === 200) {
                            chapterImage = response.data;
                        } else {
                            chapterImage = null;
                            alert("封面上传失败，请稍后再试.");
                        }
                    },
                    error: function() {
                        headImage = null;
                        alert("服务器错误，请稍后再试.");
                    }
                })
            }
        }
        reader.readAsDataURL($('#chapterImage')[0].files[0]);

        $.ajax({
            url: "${pageContext.request.contextPath}/api/content/admin",
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify({
                id: id,
                chapterTitle: $('#chapterTitle').val(),
                chapterText: $('#chapterText').val(),
                chapterImage: chapterImage ? chapterImage.name : '/cover/'+id
            }),
            success: function(response) {
                response = JSON.parse(response);
                if (response.code === 200) {
                    alert('课程内容更新成功');
                    getCourseInfo();
                    $('#contentModal').modal('hide');
                } else {
                    alert('更新失败');
                }
            }
        });
    }

    // 删除课程内容
    function deleteContent(id) {
        if (confirm('确定删除该内容吗?')) {
            $.ajax({
                url: "${pageContext.request.contextPath}/api/content/admin",
                type: 'DELETE',
                contentType: 'application/json',
                data: JSON.stringify({ id: id }),
                success: function(response) {
                    response = JSON.parse(response);
                    if (response.code === 200) {
                        alert('删除成功');
                        getCourseInfo();
                    } else {
                        alert('删除失败');
                    }
                }
            });
        }
    }


    // 初始化
    $(document).ready(function() {
        getCourseInfo();
    });
</script>
</html>
