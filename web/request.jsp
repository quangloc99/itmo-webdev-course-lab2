<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Input form - Lab 2 - Tran Quang Loc</title>
    <link href="css/theme.css" rel="stylesheet" type="text/css">
    <link href="css/shared.css" rel="stylesheet" type="text/css">
    <link href="css/input-form.css" rel="stylesheet" type="text/css">
</head>
<body>
    <% if (request.getRequestURI().endsWith("error")) { %>
        Error: ${param["error-msg"]}
    <% } %>
    <div id="input-form-container" class="container">
        <%@include file="input-form.jsp"%>
    </div>
</body>
</html>
