import {toNumber} from "./utils.js";

/**
 * @param {string|number} value
 * @param {RangeJSON} range
 */
export let bumberInRangeValidity = (value, range) => {
    if (typeof(value) === 'string') {
        if (value === '') return 'required';
        value = toNumber(value);
    }
    if (Number.isNaN(value)) return 'must be a number';
    if (value < range.low) return `must not less than ${range.low}`;
    if (value > range.high) return `must not bigger than ${range.high}`;
    return '';
};

/**
 * @param {HTMLInputElement[]} radios
 */
export let requiredRadioValidity = (radios) => radios.some(elm => elm.checked) ? '' : 'required';