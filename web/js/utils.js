/**
 * @param {number} value
 * @param {number} low
 * @param {number} high
 * @returns {boolean}
 */
export let inside = (value, {low, high}) => low <= value && value <= high;
/**
 * @param {string}strValue
 * @return {string}
 */
export let normlizeNumberSeparator = strValue => strValue.replace(/,/, '.');
/**
 * @param {string} strValue
 * @returns {number}
 */
export let toNumber = strValue => +normlizeNumberSeparator(strValue);

/**
 * @param {boolean} condition
 * @param {HTMLElement} element
 * @param {string[]} className
 */
export let addClassWhen = (condition, element, ...className) =>
    element.classList[condition ? 'add' : 'remove'](...className);

/**
 * @param {number|string} value
 * @param {{low: number, high: number}} range
 * @returns {boolean}
 */
export function isNumberInRange (value, range) {
    const numValue = typeof(value) === 'number' ? value : toNumber(value);
    return value !== '' && !Number.isNaN(numValue) && inside(numValue, range);
}