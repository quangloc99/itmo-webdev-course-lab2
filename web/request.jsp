<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Input form - Lab 2 - Tran Quang Loc</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/theme.css" rel="stylesheet" type="text/css">
    <link href="css/shared.css" rel="stylesheet" type="text/css">
    <link href="css/form-widget.css" rel="stylesheet" type="text/css">
    <link href="css/input-form.css" rel="stylesheet" type="text/css">
    <link href="css/sidebar.css" rel="stylesheet" type="text/css">
</head>
<body>
    <header class="sidebar">
        <%@include file="caption.html" %>
        <br>
        <div style="text-align: center;">
            Task<br>
            <img src="res/areas.png" width="350">
        </div>
    </header>
    <% if (request.getRequestURI().endsWith("error")) { %>
        Error: ${param["error-msg"]}
    <% } %>
    <div id="input-form-container" class="container">
        <%@include file="input-form.jsp"%>
    </div>
</body>
</html>
