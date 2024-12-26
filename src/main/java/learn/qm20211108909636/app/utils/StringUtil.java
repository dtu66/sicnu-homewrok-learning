package learn.qm20211108909636.app.utils;

public class StringUtil {
    public static boolean isEmpty(String str) {
        return str == null
                || str.isEmpty()
                || str.trim().isEmpty()
                || "null".equals(str)
                || "undefined".equals(str)
                || "NaN".equals(str)
                || "NULL".equals(str)
                || "UNDEFINED".equals(str)
                || "NAN".equals(str)
                || "nil".equals(str)
                || "NIL".equals(str);
    }
}
