<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="se.ifmo.ru.s267880.pip.lab2.DataRanges" %>

<form name="input-form">
    X:
    <span id="x-error-msg" class="error-msg"></span> <br>
    <% for (double val: DataRanges.X) { %>
        <input name="x" type="submit" value="<%=val%>">
    <% } %>
    <br>

    Y:
    <span id="y-error-msg" class="error-msg"></span> <br>
    <input name="y" type="text">
    <br>

    R: <span id="r-error-msg" class="error-msg"></span> <br>
    <% for (double val : DataRanges.R) { %>
        <label>
            <input name="r" type="radio" value="<%=val%>">
            <%=val%>
        </label>
    <% } %>
</form>

<style>
    /** Just for testing. Will be removed later */
    .error-msg {
        display: none;
    }

    .error-msg.show {
        display: inline;
    }

    input.invalid {
        border: 1px solid red;
    }
</style>

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
