package learn.qm20211108909636.app.service;

import learn.qm20211108909636.app.entity.Log;
import learn.qm20211108909636.app.vo.LogVo;
import learn.qm20211108909636.app.vo.UserLogListVo;
import learn.qm20211108909636.app.vo.UserLogVo;

import java.util.List;

public interface LogService {
    int insert(Log log);
    int delete(Integer id);
    int update(Log log);
    Log get(Integer id);
    LogVo selectUserLog(Integer userId);
    UserLogListVo search(String username, Integer page, Integer size);
}
