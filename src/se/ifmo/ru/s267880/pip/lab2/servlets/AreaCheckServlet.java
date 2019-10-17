package se.ifmo.ru.s267880.pip.lab2.servlets;

import se.ifmo.ru.s267880.pip.lab2.Query;
import se.ifmo.ru.s267880.pip.lab2.utils.ErrorSender;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;

public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ErrorSender errorSender = new ErrorSender(req, resp);
        Query query = null;
        try {
            query = (Query) req.getAttribute("transformed-query");
            Objects.requireNonNull(query, "Query not found or not being validated via /submit page. ");
            query.getResult();  // this seem useless, because the checking code is inside Query class.
            // but lab is lab, needed to be done :))
            req.getRequestDispatcher("./response").forward(req, resp);
        } catch (ClassCastException | NullPointerException e) {
            errorSender.send(e.getMessage());
        }
    }
}
