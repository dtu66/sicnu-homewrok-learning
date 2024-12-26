package learn.qm20211108909636.app.service;

import learn.qm20211108909636.app.entity.Content;
import learn.qm20211108909636.app.vo.ContentVo;

public interface ContentService {
    int add(Content content);
    int delete(Integer id);
    int update(Content content);
    Content get(Integer id, Integer userId);
    ContentVo searchBriefByPage(Content content, Integer page, Integer size, Integer userId);
    Content getAsAdmin(Integer id);
}
