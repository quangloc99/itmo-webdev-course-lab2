<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="se.ifmo.ru.s267880.pip.lab2.DataRanges" %>

<form name="input-form" action="./submit.do" method="post">
    <div class="field container">
        <div id="x-error-msg" class="error-msg"></div>
        <div class="field info">
            <div class="field name"> X: </div>
            <div class="field values">
                <% for (double val: DataRanges.X) { %>
                    <input name="x" type="submit" value="<%=val%>">
                <% } %>
            </div>
        </div>
    </div>

    <div class="field container">
        <div id="y-error-msg" class="error-msg"></div>
        <div class="field info">
            <div class="field name">Y:</div>
            <div class="field values">
                <input name="y" type="text">
            </div>
        </div>
    </div>

    <div class="field container">
        <div id="r-error-msg" class="error-msg"></div>
        <div class="field info">
            <div class="field name">R:</div>
            <div class="field values">
                <% for (double val : DataRanges.R) { %>
                <label>
                    <input name="r" type="radio" value="<%=val%>">
                    <%=val%>
                </label>
                <% } %>
            </div>
        </div>
    </div>
</form>

<script type="module" src="js/form-validation.js"> </script>
