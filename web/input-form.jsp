<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="se.ifmo.ru.s267880.pip.lab2.DataRanges" %>

<!DOCTYPE html>
<html>
<head>
    <title>Input form - Lab 2 - Tran Quang Loc</title>
</head>
<body>

    <div id="input-form-container" class="container">
        <form id="input-form">
            X: <% for (double val: DataRanges.X) { %>
                <input name="x" type="submit" value="<%=val%>">
            <% } %>
            <br>

            <label> Y: <input name="y" type="text"> </label>
            <br>

            R: <% for (double val : DataRanges.R) { %>
                <label>
                    <input name="r" type="radio" value="<%=val%>">
                    <%=val%>
                </label>
            <% } %>
        </form>
    </div>
</body>
</html>
