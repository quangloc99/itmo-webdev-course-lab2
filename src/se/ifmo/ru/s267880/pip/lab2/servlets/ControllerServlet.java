package se.ifmo.ru.s267880.pip.lab2.servlets;

import se.ifmo.ru.s267880.pip.lab2.DataRanges;
import se.ifmo.ru.s267880.pip.lab2.Query;
import se.ifmo.ru.s267880.pip.lab2.utils.ErrorSender;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class ControllerServlet extends HttpServlet {
    @FunctionalInterface
    private interface ServiceHandler {
        void service(HttpServletRequest req, HttpServletResponse resp, ErrorSender errorSender) throws ServletException, IOException;
    }

    private static final Map<String, ServiceHandler> services = new HashMap<>();
    static {
        services.put("submit.do", (req, resp, errorSender) -> {
            if (!req.getMethod().equals("POST")) {
                errorSender.send("Invalid request method. Only POST method is accepted");
                return ;
            }

            try {
                Query query = Query.fromRequest(req);
                if (!DataRanges.X.contains(query.getX())) {
                    errorSender.send(String.format(
                            "X parameter is out of range [%.1f, %.1f]", DataRanges.X.getLow(), DataRanges.X.getHigh()
                    ), true);
                } else if (!DataRanges.Y.contains(query.getY())) {
                    errorSender.send(String.format(
                            "Y parameter is out of range [%.1f, %.1f]", DataRanges.Y.getLow(), DataRanges.Y.getHigh()
                    ), true);
                } else if (!DataRanges.R.contains(query.getR())) {
                    errorSender.send(String.format(
                            "R parameter is out of range [%.1f, %.1f]", DataRanges.R.getLow(), DataRanges.R.getHigh()
                    ), true);
                }
                req.setAttribute("transformed-query", query);
            } catch (Exception e) {
                errorSender.send(e.getMessage(), true);
                return ;
            }
            req.getRequestDispatcher("/area-check").forward(req, resp);
        });

        services.put("viewtable.do", (req, resp, errorSender) -> resp.sendRedirect("./response"));
    }


    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ErrorSender errorSender = new ErrorSender(req, resp);
        String[] uriParts = req.getRequestURI().split("/");
        String serviceName = uriParts[uriParts.length - 1];

        if (!services.containsKey(serviceName)) {
            errorSender.send("Unsupported service");
            return ;
        }

        services.get(serviceName).service(req, resp, errorSender);
    }
}
