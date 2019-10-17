<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="se.ifmo.ru.s267880.pip.lab2.Query" %>
<%@ page import="se.ifmo.ru.s267880.pip.lab2.utils.ErrorSender" %>

<%--
Well, technically, LinkedList is a Bean Class:
- private properties: checked
- public zero-argument constructor: checked
- Serializable: checked
--%>
<jsp:useBean id="queryList" scope="session"
             class="java.util.LinkedList"
             type="java.util.LinkedList<se.ifmo.ru.s267880.pip.lab2.Query>"
/>

<% ErrorSender errorSender = new ErrorSender(request, response); %>
<%
    try {
        Query query = (Query) request.getAttribute("transformed-query");
        queryList.add(query);
    } catch (NullPointerException e) {
        // pass, just consider it
    } catch (ClassCastException e) {
        errorSender.send(e.getMessage());
        return ;
    }
%>

<html>
<head>
    <title>Results - Lab 2 Web - Tran Quang Loc</title>
</head>
<body>
    <% for (Query que : queryList) { %>
        <%= que.getX() %> <br>
        <%= que.getY() %> <br>
        <%= que.getR() %> <br>
        <%= que.getResult() %> <br>
    <% } %>
</body>
</html>
