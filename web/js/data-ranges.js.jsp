<%@ page contentType="text/javascript; charset=UTF-8" %>
<%@ page import="se.ifmo.ru.s267880.pip.lab2.DataRanges" %>

/**
 * @typedef {Object} RangeJSON
 * @property {number} low
 * @property {number} high
 * @property {number} step
 */

export default {
    /** @type {RangeJSON} */
    X: <%= DataRanges.X.toJSON()%>,
    /** @type {RangeJSON} */
    Y: <%= DataRanges.Y.toJSON()%>,
    /** @type {RangeJSON} */
    R: <%= DataRanges.R.toJSON()%>
};

