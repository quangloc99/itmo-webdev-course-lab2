<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Input form - Lab 2 - Tran Quang Loc</title>
</head>
<body>
    <% if (request.getAttribute("error-message") != null) { %>
        Error: ${requestScope["error-message"]}
    <% } %>
    <div id="input-form-container" class="container">
        <%@include file="input-form.jsp"%>
    </div>
</body>
</html>
