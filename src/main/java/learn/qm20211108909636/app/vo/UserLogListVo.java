package learn.qm20211108909636.app.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserLogListVo {
    private Integer total;
    private List<UserLogVo> logs;
}
