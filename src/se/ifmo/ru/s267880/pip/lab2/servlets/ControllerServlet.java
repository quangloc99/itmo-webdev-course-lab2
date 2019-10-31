package se.ifmo.ru.s267880.pip.lab2.servlets;

import se.ifmo.ru.s267880.pip.lab2.DataRanges;
import se.ifmo.ru.s267880.pip.lab2.Query;
import se.ifmo.ru.s267880.pip.lab2.utils.ErrorSender;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class ControllerServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ErrorSender sender = new ErrorSender(req, resp);
        String uri = req.getRequestURI();

        for (Method med: ControllerServlet.class.getDeclaredMethods()) {
            if (med.getName().equals("service")) continue;
            String methodName = med.getName();
            if (uri.endsWith("/" + methodName)) {
                try {
                    med.setAccessible(true);
                    med.invoke(this, req, resp);
                } catch (IllegalAccessException | InvocationTargetException e) {
                    if (e instanceof InvocationTargetException) {
                        if (e.getCause() instanceof ServletException) {
                            throw (ServletException) e.getCause();
                        }
                        if (e.getCause() instanceof IOException) {
                            throw (IOException) e.getCause();
                        }
                    }

                    sender.send("Weird things happens on the server because the developer used black magic. " +
                            "Please contact the developer.");
                }
                return ;
            }
        }
        sender.send("Unsupported service");
    }

    private void submit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ErrorSender errorSender= new ErrorSender(req, resp);
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
        }
        req.getRequestDispatcher("./area-check").forward(req, resp);
    }

    private void viewtable(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.sendRedirect("./response");
    }
}
