package se.ifmo.ru.s267880.pip.lab2.servlets;

import se.ifmo.ru.s267880.pip.lab2.DataRanges;
import se.ifmo.ru.s267880.pip.lab2.Query;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

public class ControllerServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!req.getMethod().equals("POST")) {
            sendError(req, resp, "Invalid request method. Only POST method is accepted.");
            return ;
        }


        try {
            Query query = Query.fromRequest(req);
            if (!DataRanges.X.contains(query.getX())) {
                sendError(req, resp, String.format(
                        "X parameter is out of range [%.1f, %.1f]", DataRanges.X.getLow(), DataRanges.X.getHigh()
                ));
            } else if (!DataRanges.Y.contains(query.getY())) {
                sendError(req, resp, String.format(
                        "Y parameter is out of range [%.1f, %.1f]", DataRanges.Y.getLow(), DataRanges.Y.getHigh()
                ));
            } else if (!DataRanges.R.contains(query.getR())) {
                sendError(req, resp, String.format(
                        "R parameter is out of range [%.1f, %.1f]", DataRanges.R.getLow(), DataRanges.R.getHigh()
                ));
            }
        } catch (Exception e) {
            sendError(req, resp, e.getMessage());
        }
        resp.getWriter().write("nice");
    }

    private void sendError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException
    {
        req.setAttribute("error-message", message);
        req.getRequestDispatcher("./request").forward(req, resp);
    }
}
