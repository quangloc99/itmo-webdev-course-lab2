package se.ifmo.ru.s267880.pip.lab2.utils;

import java.lang.Iterable;
import java.util.Iterator;

import static se.ifmo.ru.s267880.pip.lab2.utils.MathUtils.eps;

public class Range implements Iterable<Double> {
    private double low;
    private double high;
    private double step;

    public Range(double low, double high, double step) {
        this.low = low;
        this.high = high;
        this.step = step;
    }

    public Range(double low, double high) {
        this(low, high, 1);
    }

    public double getLow() {
        return low;
    }

    public double getHigh() {
        return high;
    }

    public boolean contains(double val) {
        return low -eps < val && val < high + eps;
    }


    @Override
    public Iterator<Double> iterator() {
        if (step <= 0) {
            throw new IllegalArgumentException("step must be positive.");
        }
        return new Iterator<Double>() {
            double cur = low;
            @Override
            public boolean hasNext() {
                return cur < high + eps;
            }

            @Override
            public Double next() {
                double oldVal = cur;
                cur += step;
                return oldVal;
            }
        };
    }

    public String toJSON() {
        return String.format("{"+
                "\"low\": %f, " +
                "\"high\": %f, " +
                "\"step\": %f" +
                "}", low, high, step);
    }
}
