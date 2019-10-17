<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Input form - Lab 2 - Tran Quang Loc</title>
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
