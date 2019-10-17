package se.ifmo.ru.s267880.pip.lab2.utils;

public class StringUtils {
    public static String normalizeNumberSeparator(String str, String separatorRegex) {
        return str.replaceAll(separatorRegex, ".");
    }

    public static String normalizeNumberSeparator(String str) {
        return normalizeNumberSeparator(str, ",");
    }
}
