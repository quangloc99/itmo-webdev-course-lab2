package se.ifmo.ru.s267880.pip.lab2.utils;

import javax.servlet.ServletRequest;
import java.util.Objects;

public class RequestWrapper {
    private ServletRequest request;

    public RequestWrapper(ServletRequest request) {
        Objects.requireNonNull(request);
        this.request = request;
    }

    public String getParameter(String name, boolean required) {
        String field = request.getParameter(name);
        if (required) {
            Objects.requireNonNull(field, "Required parameter " + name + " is missing.");
        }
        return field;
    }

    public Double getDoubleParameter(String name, boolean required, boolean normalizeSeparator) {
        String field = getParameter(name, required);
        if (normalizeSeparator) {
            field = StringUtils.normalizeNumberSeparator(field);
        }
        try {
            return Double.parseDouble(field);
        } catch (NumberFormatException e) {
            throw new NumberFormatException(String.format("Field %s must be a number", name));
        }
    }

    public Double getDoubleParameter(String name, boolean required) {
        return getDoubleParameter(name, required, true);
    }
}
