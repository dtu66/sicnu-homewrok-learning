package learn.qm20211108909636.app.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import learn.qm20211108909636.app.entity.Userinfo;
import learn.qm20211108909636.app.vo.UserVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserDao{
    /**
     * 作者：2021110890 张广福
     * 插入userinfo数据
     * @param userinfo userinfo对象
     */
    int insert(Userinfo userinfo);
    /**
     * 作者：2021110890 张广福
     * 删除userinfo数据
     * @param id userinfo的id
     */
    int delete(Integer id);
    /**
     * 作者：2021110890 张广福
     * 更新userinfo数据
     * @param userinfo userinfo对象
     */
    int update(Userinfo userinfo);
    /**
     * 作者：2021110890 张广福
     * 获取userinfo数据
     * @param id userinfo的id
     */
    Userinfo get(Integer id);
    /**
     * 作者：2021110890 张广福
     * 登录
     * @param username 用户名
     * @param password 密码
     */
    Userinfo login(String username, String password);
    /**
     * 作者：2021110890 张广福
     * 通过用户名查找用户
     * @param username 用户名
     */
    Userinfo selectByUsername(String username);
    /**
     * 作者：2021110890 张广福
     * 通过用户名查找用户
     * @param username 用户名
     */
    UserVo searchByPage(String username,String role, Integer start, Integer size);
    /**
     * 作者：2021110890 张广福
     * 获取用户信息
     * @param size 获取数量
     */
    List<Userinfo> latestStudy(Integer size);
    /**
     * 作者：2021110890 张广福
     * 获取用户信息
     * @param size 获取数量
     */
    List<Userinfo> mostStudy(Integer size);
}
