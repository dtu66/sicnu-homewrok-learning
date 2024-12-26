<%@ page import="learn.qm20211108909636.app.entity.Userinfo" %><%--
  Created by IntelliJ IDEA.
  User: void
  Date: 2024/12/25
  Time: 9:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% Userinfo user = (Userinfo) session.getAttribute("user") ;%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>模板</title>
    <jsp:include page="./common/include.jsp"/>
</head>
<body>
<%@ include file="./common/user/header.jsp" %>

<%@ include file="./common/footer.jsp" %>
</body>
</html>
