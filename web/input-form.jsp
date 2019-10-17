<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="se.ifmo.ru.s267880.pip.lab2.DataRanges" %>

<form name="input-form" action="./submit" method="post">
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

<script type="module" >
    import dataRanges from "./js/data-ranges.js.jsp";
    import {bumberInRangeValidity, requiredRadioValidity} from './js/validation-utils.js';
    import {createValidator} from './js/validator.js';

    /**
     * @type {string}
     */
    const formSelector = '[name="input-form"]';

    const xValidator = createValidator({
        targetSelector: `\${formSelector} [name="x"]`,   // \$ for JSP, after compilation it is still $
        messageSelector: '#x-error-msg',
        hideMessageOn: ['click', 'input', 'touch'],
        onValidate: elements => elements.some(elm => elm === document.activeElement) ? '' : 'click here to choose X before submitting',
    });

    const yValidator = createValidator({
        targetSelector: `\${formSelector} [name="y"]`,
        messageSelector: `#y-error-msg`,
        hideMessageOn: ['input'],
        onValidate: ([element]) => bumberInRangeValidity(element.value, dataRanges.Y),
    });

    const rValidator = createValidator({
        targetSelector: `\${formSelector} [name="r"]`,
        messageSelector: '#r-error-msg',
        hideMessageOn: ['input', 'click', 'touch'],
        onValidate: requiredRadioValidity,
    });

    const validators = [xValidator, yValidator, rValidator];

    document.querySelector(formSelector).addEventListener('submit', evt => {
        console.log(evt);
        if (validators.map(validate => validate(evt)).some(self => !self)) {
            evt.preventDefault();
        }
    });
</script>
