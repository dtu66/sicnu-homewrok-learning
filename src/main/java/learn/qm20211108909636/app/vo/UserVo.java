package learn.qm20211108909636.app.vo;

import learn.qm20211108909636.app.entity.Userinfo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserVo {
    private Integer total;
    private List<Userinfo> list;
}
