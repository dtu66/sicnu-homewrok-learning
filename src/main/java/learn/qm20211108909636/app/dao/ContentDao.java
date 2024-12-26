package learn.qm20211108909636.app.dao;

import learn.qm20211108909636.app.vo.ContentVo;
import learn.qm20211108909636.app.entity.Content;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ContentDao{
    /**
     * 作者：2021110836蒋华培
     * 插入content数据
     * @param content content对象
     */
    int insert(Content content);
    /**
     * 作者：2021110836蒋华培
     * 删除content数据
     * @param id content的id
     */
    int delete(Integer id);
    /**
     * 作者：2021110836蒋华培
     * 更新content数据
     * @param content content对象
     */
    int update(Content content);
    /**
     * 作者：2021110836蒋华培
     * 获取content数据
     * @param id content的id
     */
    Content get(Integer id);
    /**
     * 作者：2021110890 张广福
     * 分页获取content数据
     * @param content content对象
     */
    ContentVo searchBriefByPage(Content content, Integer start, Integer size, Integer userId);
}
