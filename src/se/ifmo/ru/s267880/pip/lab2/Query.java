package se.ifmo.ru.s267880.pip.lab2;

import se.ifmo.ru.s267880.pip.lab2.utils.RequestWrapper;

import javax.servlet.ServletRequest;

public class Query {
    private double x;
    private double y;
    private double r;
    private Boolean result;

    public Query(double x, double y, double r) {
        this.x = x;
        this.y = y;
        this.r = r;
    }

    public static Query fromRequest(RequestWrapper req) {
        return new Query(
                req.getDoubleParameter("x", true),
                req.getDoubleParameter("y", true),
                req.getDoubleParameter("r", true)
        );
    }

    public static Query fromRequest(ServletRequest req) {
        return fromRequest(new RequestWrapper(req));
    }

    public boolean getResult() {
        if (result != null) return result;
        return result = isPointInArea();
    }

    private boolean isPointInArea() {
        final double eps = 1e-9;
        if (x < 0 && y > 0) return false;
        if (x < 0 && y < 0) return x * x + y * y < r * r + eps;
        if (x > 0 && y < 0) return x < r + eps && y * 2 > r - eps;
        if (x > 0 && y > 0) return x + 2 * y < r + eps;
        throw new RuntimeException("wtf???");
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getR() {
        return r;
    }
}
