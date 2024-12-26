package learn.qm20211108909636.app.Enum;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Role {
    ADMIN(1, "ADMIN"),
    USER(2, "USER");

    private final int code;
    private final String description;
}
