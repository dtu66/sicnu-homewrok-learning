<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Jquery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js" type="text/javascript"></script>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- 引入 CKEditor 样式和脚本 -->
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>



<script>
    function toIndex() {
        window.location.href = '${pageContext.request.contextPath}/index';
    }

    function toTest() {
        window.location.href = 'test';
    }



    function errorDialog(message) {
        alert(message);
    }
</script>