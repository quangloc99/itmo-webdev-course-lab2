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
    Query newQuery = null;
    try {
        newQuery = (Query) request.getAttribute("transformed-query");
        if (newQuery != null) queryList.addFirst(newQuery);
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
    <link href="css/form-widget.css" rel="stylesheet" type="text/css">
</head>
<body>
    <header class="sidebar">
        <%@ include file="caption.html"%>
        <div style="text-align:center">
            Result<br>
            <div id="query-displayer">
                <style>
                    #query-displayer-areas,
                    #query-displayer-points {
                        position: relative;
                        top: 0;
                        left: 100px;
                    }
                    #query-displayer-areas svg,
                    #query-displayer-points .point {
                        position: absolute;
                        top: 0;
                        left: 0;
                    }

                    #query-displayer-points .point {
                        text-shadow: 2px 3px 10px rgba(255, 255, 255, 1);
                        color: yellow;
                    }

                    #query-displayer-points .point {
                        transform: translate(-50%, -50%);
                    }
                    #query-displayer-areas svg .shapes {
                        filter: drop-shadow(var(--inactive-shadow));
                    }
                </style>
                <div id="query-displayer-areas">
                    <%@ include file="area-template.html" %>
                </div>
                <div id="query-displayer-points">
                    <div class="point"></div>
                </div>
            </div>
        </div>
    </header>

    <button onclick="window.location='./request'">Add new query</button>
    <h2>Hover on the row to show the query on the left.</h2>
    <table class="query-table">
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

    <script type="module">
        import {CoordinatesConverter} from "./js/CoordinatesConverter.js";
        import dataRanges from './js/data-ranges.js.jsp';
        const svg = document.querySelector('#query-displayer-areas svg');
        const queriesTableRow = Array.from(document.querySelector(".query-table tbody").children);
        const queryPoint = document.querySelector('#query-displayer-points .point');

        let coordinatesConverter = null;

        coordinatesConverter = new CoordinatesConverter(
            svg.viewBox.baseVal.width / 2,
            Math.max(dataRanges.X.high, dataRanges.Y.high, dataRanges.R.high),
            {x: svg.viewBox.baseVal.width / 2, y: svg.viewBox.baseVal.height / 2}
        );

        const parseTableRowToQuery = (tableRow) => {
            const children = tableRow.children;
            return {
                x: children[0].innerHTML,
                y: children[1].innerHTML,
                r: children[2].innerHTML,
                result: children[3].innerHTML.includes('true')
            }
        };

        const setCurrentQueryToDisplayer = ({x, y, r, result}) => {
            const newR = coordinatesConverter.displaySizeToAreaSize(r);
            svg.style.setProperty('--optional-radius', `\${newR}px`);
            svg.style.setProperty('--optional-color', result ? 'green' : 'red');
            queryPoint.innerHTML = result ? '✔' : '✕';
            const {x: newX, y: newY} = coordinatesConverter.displayCoordinatesToArea({x, y: -y});
            queryPoint.style.top = `\${newY}px`;
            queryPoint.style.left= `\${newX}px`;
        };


        queriesTableRow.forEach(row => {
            row.addEventListener('mouseenter', event => setCurrentQueryToDisplayer(parseTableRowToQuery(row)));
            row.addEventListener('mouseout', event => setCurrentQueryToDisplayer(parseTableRowToQuery(queriesTableRow[0])));
        });

        if (queriesTableRow.length !== 0) {
            setCurrentQueryToDisplayer(parseTableRowToQuery(queriesTableRow[0]));
        }


    </script>
</body>
</html>
