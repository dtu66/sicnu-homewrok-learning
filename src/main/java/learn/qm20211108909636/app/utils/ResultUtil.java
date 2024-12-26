package learn.qm20211108909636.app.utils;

import learn.qm20211108909636.app.Enum.StatusCode;
import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class ResultUtil {
    //状态码
    private Integer code;
    //信息
    private String message;
    //数据
    private Object data;

    private ResultUtil() {}

    private static class SingletonHolder {
        private static final ResultUtil INSTANCE = new ResultUtil();
    }

    public static ResultUtil getInstance() {
        return SingletonHolder.INSTANCE;
    }

    public String toJsonString() {
        //return JSON.toJSONString(this);
        return JsonUtil.getJson(this);
    }

    public static String success(StatusCode statusCode, Object data) {
        return ResultUtil.getInstance().setCode(statusCode.getCode()).setMessage(statusCode.getMessage()).setData(data).toJsonString();
    }

    public static String success(Object data) {
        return ResultUtil.success(StatusCode.SUCCESS, data);
    }

    public static String success(StatusCode statusCode) {
        return ResultUtil.success(statusCode, null);
    }

    public static String success() {
        return ResultUtil.success(StatusCode.SUCCESS, null);
    }

    public static String error(StatusCode statusCode, Object data) {
        return ResultUtil.getInstance().setCode(statusCode.getCode()).setMessage(statusCode.getMessage()).setData(data).toJsonString();
    }

    public static String error(Object data) {
        return ResultUtil.error(StatusCode.ERROR, data);
    }

    public static String error(StatusCode statusCode) {
        return ResultUtil.error(statusCode, null);
    }

    public static String error() {
        return ResultUtil.error(StatusCode.ERROR, null);
    }
}
