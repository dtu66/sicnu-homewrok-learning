package learn.qm20211108909636.app.service.impl;

import learn.qm20211108909636.app.dao.LogDao;
import learn.qm20211108909636.app.entity.Log;
import learn.qm20211108909636.app.service.LogService;
import learn.qm20211108909636.app.vo.LogVo;
import learn.qm20211108909636.app.vo.UserLogListVo;
import learn.qm20211108909636.app.vo.UserLogVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LogServiceImpl implements LogService {

    @Autowired
    private LogDao logDao;

    @Override
    public int insert(Log log) {
        return logDao.insert(log);
    }

    @Override
    public int delete(Integer id) {
        return logDao.delete(id);
    }

    @Override
    public int update(Log log) {
        return logDao.update(log);
    }

    @Override
    public Log get(Integer id) {
        return logDao.get(id);
    }

    @Override
    public LogVo selectUserLog(Integer userId) {
        List<Log> log = logDao.getUserStudyLog(userId);
        List<Integer> userStudiedId = logDao.getUserStudiedId(userId);
        return new LogVo(userStudiedId, log);
    }

    @Override
    public UserLogListVo search(String username, Integer page, Integer size) {
        UserLogListVo userLogListVo = new UserLogListVo();
        userLogListVo.setTotal(logDao.searchUserLogCount(username));
        userLogListVo.setLogs(logDao.searchUserLogByPage(username, (page-1)*size, size));
        return userLogListVo;
    }


}
