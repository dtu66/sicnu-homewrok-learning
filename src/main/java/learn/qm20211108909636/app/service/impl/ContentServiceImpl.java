package learn.qm20211108909636.app.service.impl;

import learn.qm20211108909636.app.dao.ContentDao;
import learn.qm20211108909636.app.dao.LogDao;
import learn.qm20211108909636.app.entity.Log;
import learn.qm20211108909636.app.service.LogService;
import learn.qm20211108909636.app.utils.TimeUtil;
import learn.qm20211108909636.app.vo.ContentVo;
import learn.qm20211108909636.app.entity.Content;
import learn.qm20211108909636.app.service.ContentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

@Service
public class ContentServiceImpl implements ContentService {

    @Autowired
    private ContentDao contentDao;

    @Autowired
    private LogDao logDao;

    @Override
    public int add(Content content) {
        return contentDao.insert(content);
    }

    @Override
    public int delete(Integer id) {
        return contentDao.delete(id);
    }

    @Override
    public int update(Content content) {
        return contentDao.update(content);
    }

    @Override
    @Transactional
    public Content get(Integer id, Integer uid) {
        Content content = contentDao.get(id);
        if (content == null) return null;
        content.setHits(content.getHits()+1);
        logDao.insert(new Log(uid,id, new Date()));
        contentDao.update(content);
        return content;
    }

    @Override
    public ContentVo searchBriefByPage(Content content, Integer page, Integer size, Integer uid) {
        return contentDao.searchBriefByPage(content, (page-1)*size, size, uid);
    }

    @Override
    public Content getAsAdmin(Integer id) {
        return contentDao.get(id);
    }
}
