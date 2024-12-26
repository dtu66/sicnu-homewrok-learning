<%--
  Created by IntelliJ IDEA.
  User: void
  Date: 2024/12/24
  Time: 20:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer class="footer bg-dark text-white py-4">
    <div class="container">
        <!-- 页脚链接 -->
        <div class="d-flex justify-content-center mb-3">
            <a href="${pageContext.request.contextPath}/about" class="text-white mx-3" style="text-decoration: none;">关于我们</a>
            <a href="${pageContext.request.contextPath}/contact" class="text-white mx-3" style="text-decoration: none;">联系我们</a>
            <a href="${pageContext.request.contextPath}/privacy" class="text-white mx-3" style="text-decoration: none;">隐私政策</a>
            <a href="${pageContext.request.contextPath}/terms" class="text-white mx-3" style="text-decoration: none;">服务条款</a>
        </div>
        <!-- 小组信息 -->
        <div class="text-center">
            <p>小组成员：张广福@2021110890、邹明道@2021110896、蒋华培@2021110836</p>
            <p>项目名称：校规学习</p>
            <p>版权所有 &copy; 2024 | <a href="https://github.com/your-group" target="_blank" class="text-white" style="text-decoration: none;">GitHub</a></p>
        </div>
    </div>
</footer>