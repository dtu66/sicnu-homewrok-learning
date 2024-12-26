package learn.qm20211108909636.app.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import learn.qm20211108909636.app.Enum.StatusCode;
import learn.qm20211108909636.app.dao.UserDao;
import learn.qm20211108909636.app.entity.Userinfo;
import learn.qm20211108909636.app.service.UserService;
import learn.qm20211108909636.app.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public Userinfo login(String username, String password) {
        return userDao.login(username, password);
    }

    @Override
    public int register(Userinfo userinfo) {
        Userinfo verify = userDao.selectByUsername(userinfo.getUsername());
        if (verify != null) return -1;
        return userDao.insert(userinfo);
    }

    @Override
    public int delete(Integer id) {
        return userDao.delete(id);
    }

    @Override
    public int update(Userinfo userinfo) {
        return userDao.update(userinfo);
    }

    @Override
    public Userinfo selectById(Integer id) {
        return userDao.get(id);
    }

    @Override
    public Userinfo selectByUsername(String username) {
        return userDao.selectByUsername(username);
    }

    @Override
    public UserVo searchByPage(String username,String role, Integer page, Integer size) {
        return userDao.searchByPage(username,role, (page-1)*size, size);
    }

    @Override
    public List<Userinfo> latestStudy(Integer size) {
        return userDao.latestStudy(size);
    }

    @Override
    public List<Userinfo> mostStudy(Integer size) {
        return userDao.mostStudy(size);
    }
}
