package learn.qm20211108909636.app.vo;

import learn.qm20211108909636.app.entity.Log;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class LogVo {
    List<Integer> studiedId;
    List<Log> logs;
}
