package learn.qm20211108909636.app.service;

import learn.qm20211108909636.app.entity.Userinfo;
import learn.qm20211108909636.app.vo.UserVo;

import java.util.List;

public interface UserService {
    Userinfo login(String username, String password);
    int register(Userinfo userinfo);
    int delete(Integer id);
    int update(Userinfo userinfo);
    Userinfo selectById(Integer id);
    Userinfo selectByUsername(String username);
    UserVo searchByPage(String username,String role, Integer page, Integer size);
    List<Userinfo> latestStudy(Integer size);
    List<Userinfo> mostStudy(Integer size);
}
