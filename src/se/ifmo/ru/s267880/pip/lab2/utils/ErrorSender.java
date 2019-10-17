package se.ifmo.ru.s267880.pip.lab2.utils;

import static se.ifmo.ru.s267880.pip.lab2.utils.StringUtils.encodeURL;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.stream.Collectors;

public class ErrorSender {
    private HttpServletRequest req;
    private HttpServletResponse resp;

    public ErrorSender(HttpServletRequest req, HttpServletResponse resp) {
        this.req = req;
        this.resp = resp;
    }

    public void send(String message, boolean withRequestParameter) throws IOException {
        String url = "./error?error-msg=" + encodeURL(message);
        if (withRequestParameter) {
            url += "&" + req.getParameterMap().entrySet()
                    .stream()
                    .map(entry -> Arrays.stream(entry.getValue())
                            .map(value -> encodeURL(entry.getKey()) + "=" + encodeURL(value))
                            .collect(Collectors.joining("&"))
                    ).collect(Collectors.joining("&"));
        }
        resp.sendRedirect(url);
    }

    public void send(String message) throws IOException {
        send(message, false);
    }
}
