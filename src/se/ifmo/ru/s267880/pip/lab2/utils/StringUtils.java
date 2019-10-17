package se.ifmo.ru.s267880.pip.lab2.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class StringUtils {
    public static String normalizeNumberSeparator(String str, String separatorRegex) {
        return str.replaceAll(separatorRegex, ".");
    }

    public static String normalizeNumberSeparator(String str) {
        return normalizeNumberSeparator(str, ",");
    }

    public static String encodeURL(String str) {
        try {
            return URLEncoder.encode(str, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }
}
