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
        queryList.addFirst(query);
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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/theme.css" rel="stylesheet" type="text/css">
    <link href="css/shared.css" rel="stylesheet" type="text/css">
    <link href="css/table.css" rel="stylesheet" type="text/css">
    <link href="css/sidebar.css" rel="stylesheet" type="text/css">
</head>
<body>
    <header class="sidebar">
        <%@ include file="caption.html"%>
    </header>

    <table>
        <thead>
            <tr>
                <th>X</th>
                <th>Y</th>
                <th>R</th>
                <th>Result</th>
            </tr>
        </thead>
        <tbody>
            <% for (Query que : queryList) { %>
            <tr class="<%= que.getResult() ? "positive-result" : "negative-result" %>">
                <td class="column x"><%= String.format("%.3f", que.getX()) %></td>
                <td class="column y"><%= String.format("%.3f", que.getY()) %></td>
                <td class="column r"><%= String.format("%.3f", que.getR()) %></td>
                <td class="column result"><%-- CSS's job--%> <%= que.getResult() %></td>
            </tr>
            <% } %>
        </tbody>

    </table>
</body>
</html>
