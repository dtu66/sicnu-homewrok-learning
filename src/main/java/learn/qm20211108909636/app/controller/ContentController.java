package learn.qm20211108909636.app.controller;

import jakarta.servlet.http.HttpSession;
import learn.qm20211108909636.app.Enum.StatusCode;
import learn.qm20211108909636.app.entity.Content;
import learn.qm20211108909636.app.entity.Userinfo;
import learn.qm20211108909636.app.service.ContentService;
import learn.qm20211108909636.app.utils.ResultUtil;
import learn.qm20211108909636.app.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Objects;

/**
 * 作者：2021110890 张广福
 * 内容控制器
 */
@RestController
@RequestMapping("/api/content")
public class ContentController {

    @Autowired
    private ContentService contentService;

    @GetMapping("/{id}")
    public String getContent(@PathVariable Integer id, HttpSession session) {
        Userinfo user = (Userinfo) session.getAttribute("user");
        if (user == null) {
            return ResultUtil.error(StatusCode.UNAUTHORIZED);
        }
        Content content = contentService.get(id,user.getId());
        System.out.println(content);
        if (content == null) {
            return ResultUtil.error(StatusCode.NOT_FOUND);
        }
        return ResultUtil.success(content);
    }

    @PostMapping("search")
    public String search(@RequestBody Map<String, String> data, HttpSession session) {
        Userinfo user = (Userinfo) session.getAttribute("user");
        Integer chapterId = StringUtil.isEmpty(data.get("chapterId")) ? null : Integer.parseInt(data.get("id"));
        String chapterTitle = StringUtil.isEmpty(data.get("chapterTitle")) ? null : data.get("chapterTitle");
        String chapterText = StringUtil.isEmpty(data.get("chapterText")) ? null : data.get("chapterText");
        Integer page = StringUtil.isEmpty(data.get("page")) ? 1 : Integer.parseInt(data.get("page"));
        Integer size = StringUtil.isEmpty(data.get("size")) ? 10 : Integer.parseInt(data.get("size"));

        Content content = new Content();
        if (chapterId != null)
            content.setChapterId(chapterId);
        if (chapterTitle != null)
            content.setChapterTitle(chapterTitle);
        if (chapterText != null)
            content.setChapterText(chapterText);
        return ResultUtil.success(contentService.searchBriefByPage(content, page, size,user==null ? null:user.getId()));

    }

    @GetMapping("/admin/{id}")
    public String getContentAdmin(@PathVariable Integer id, HttpSession session) {
        Userinfo user = (Userinfo) session.getAttribute("user");
        if (user == null) {
            return ResultUtil.error(StatusCode.UNAUTHORIZED);
        }
        Content content = contentService.getAsAdmin(id);
        System.out.println(content);
        if (content == null) {
            return ResultUtil.error(StatusCode.NOT_FOUND);
        }
        return ResultUtil.success(content);
    }

    @PostMapping("/admin/add")
    public String addContent(@RequestBody Content content, HttpSession session) {
        Userinfo user = (Userinfo) session.getAttribute("user");
        if (user == null || !Objects.equals(user.getRole(), "admin")) {
            return ResultUtil.error(StatusCode.UNAUTHORIZED);
        }
        if (content.getChapterId() == null || content.getChapterTitle() == null || content.getChapterText() == null) {
            return ResultUtil.error(StatusCode.PARAM_ERROR);
        }
        content.setHits(0);
        contentService.add(content);
        return ResultUtil.success();
    }

    @DeleteMapping("/admin")
    public String deleteContent(@RequestBody Map<String, Integer> data, HttpSession session) {
        Userinfo user = (Userinfo) session.getAttribute("user");
        if (user == null || !Objects.equals(user.getRole(), "admin")) {
            return ResultUtil.error(StatusCode.UNAUTHORIZED);
        }
        if (data.get("id") == null) {
            return ResultUtil.error(StatusCode.PARAM_ERROR);
        }
        contentService.delete(data.get("id"));
        return ResultUtil.success();
    }

    @PutMapping("/admin")
    public String updateContent(@RequestBody Map<String,String> map, HttpSession session) {
        Userinfo user = (Userinfo) session.getAttribute("user");
        if (user == null || !Objects.equals(user.getRole(), "admin")) {
            return ResultUtil.error(StatusCode.UNAUTHORIZED);
        }
        String chapterTitle = StringUtil.isEmpty(map.get("chapterTitle")) ? null : map.get("chapterTitle");
        String chapterText = StringUtil.isEmpty(map.get("chapterText")) ? null : map.get("chapterText");
        String chapterImage = StringUtil.isEmpty(map.get("chapterImage")) ? null : map.get("chapterImage");
        Integer id = StringUtil.isEmpty(map.get("id")) ? null : Integer.parseInt(map.get("id"));
        Content content = new Content();
        content.setId(id);
        content.setChapterTitle(chapterTitle);
        content.setChapterText(chapterText);
        content.setChapterImage(chapterImage);
        if (content.getId() == null || content.getChapterId() == null || content.getChapterTitle() == null || content.getChapterText() == null) {
            return ResultUtil.error(StatusCode.PARAM_ERROR);
        }
        contentService.update(content);
        return ResultUtil.success();
    }



}
