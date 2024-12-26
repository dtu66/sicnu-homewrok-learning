package learn.qm20211108909636.app.Enum;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum StatusCode {
    SUCCESS(200, "success"),
    ERROR(500, "fail"),

    EXITS(200, "exist"),
    NOT_EXITS(200, "none"),

    UNAUTHORIZED(401, "请登录"),
    FORBIDDEN(403, "禁止访问：权限不足"),

    ERROR_REGISTER(500, "注册失败"),
    WRONG_CREDENTIALS(401, "账号或密码错误"),


    USERNAME_EXISTS(401, "用户名已存在"),

    NOT_FOUND(404, "未找到"),


    PARAM_ERROR(401, "参数错误"),;

    private final int code;
    private final String message;
}
