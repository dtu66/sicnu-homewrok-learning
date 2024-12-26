package learn.qm20211108909636.app.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import learn.qm20211108909636.app.entity.Log;
import learn.qm20211108909636.app.vo.UserLogListVo;
import learn.qm20211108909636.app.vo.UserLogVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface LogDao{
    /**
     * 作者：2021110896 邹明道
     * 插入log数据
     * @param log log对象
     */
    int insert(Log log);
    /**
     * 作者：2021110896 邹明道
     * 删除log数据
     * @param id log的id
     */
    int delete(Integer id);
    /**
     * 作者：2021110896 邹明道
     * 更新log数据
     * @param log log对象
     */
    int update(Log log);
    /**
     * 作者：2021110896 邹明道
     * 获取log数据
     * @param id log的id
     */
    Log get(Integer id);
    /**
     * 作者：2021110896 邹明道
     * 获取用户学习记录
     * @param userId 用户id
     */
    List<Log> getUserStudyLog(Integer userId);
    /**
     * 作者：2021110836 蒋华培
     * 获取用户学习记录
     * @param userId 用户id
     */
    List<Integer> getUserStudiedId(Integer userId);

    /**
     * 作者：2021110890 张广福
     * 分页获取log数据
     * @param username
     * @param start
     * @param size
     * @return
     */
    List<UserLogVo> searchUserLogByPage(String username, Integer start, Integer size);
    /**
     * 作者：2021110890 张广福
     * 获取log数据总数
     * @param username
     * @return
     */
    Integer searchUserLogCount(String username);

    /**
     * 作者：2021110836 蒋华培
     * @param user_id
     * @return
     */
    Log queryLastLog(Integer user_id);
}
