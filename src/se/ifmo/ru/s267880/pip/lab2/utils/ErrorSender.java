package se.ifmo.ru.s267880.pip.lab2.utils;

import static se.ifmo.ru.s267880.pip.lab2.utils.StringUtils.encodeURL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.stream.Collectors;

public class ErrorSender {
    private HttpServletRequest req;
    private HttpServletResponse resp;
    private String url;
    private String messageParameterName;

    public ErrorSender(HttpServletRequest req, HttpServletResponse resp) {
        this(req, resp, "./error", "error-msg");
    }

    public ErrorSender(HttpServletRequest req, HttpServletResponse resp, String url, String messageParameterName) {
        this.req = req;
        this.resp = resp;
        this.url = url;
        this.messageParameterName = messageParameterName;
    }

    public void send(String message, boolean withRequestParameter) throws IOException {
        String resultUrl = url + "?" + encodeURL(messageParameterName) + "=" + encodeURL(message);
        if (withRequestParameter) {
            resultUrl += "&" + req.getParameterMap().entrySet()
                    .stream()
                    .map(entry -> Arrays.stream(entry.getValue())
                            .map(value -> encodeURL(entry.getKey()) + "=" + encodeURL(value))
                            .collect(Collectors.joining("&"))
                    ).collect(Collectors.joining("&"));
        }
        resp.sendRedirect(resultUrl);
    }

    public void send(String message) throws IOException {
        send(message, false);
    }
}
