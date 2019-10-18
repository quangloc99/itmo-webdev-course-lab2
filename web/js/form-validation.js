import dataRanges from "./data-ranges.js.jsp";
import {bumberInRangeValidity, requiredRadioValidity} from './validation-utils.js';
import {createValidator} from './validator.js';

/**
 * @type {string}
 */
const formSelector = '[name="input-form"]';

export const xValidator = createValidator({
    targetSelector: `${formSelector} [name="x"]`,   // \$ for JSP, after compilation it is still $
    messageSelector: '#x-error-msg',
    hideMessageOn: ['click', 'input', 'touch'],
    onValidate: elements => elements.some(elm => elm === document.activeElement) ? '' : 'click here to choose X before submitting',
});

export const yValidator = createValidator({
    targetSelector: `${formSelector} [name="y"]`,
    messageSelector: `#y-error-msg`,
    hideMessageOn: ['input'],
    onValidate: ([element]) => bumberInRangeValidity(element.value, dataRanges.Y),
});

export const rValidator = createValidator({
    targetSelector: `${formSelector} [name="r"]`,
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
