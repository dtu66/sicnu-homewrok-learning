package learn.qm20211108909636.app.entity;

import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;

@TableName("content")
public class Content implements Serializable {
    /*
    * content
content 表有 6 个字段
id，主键，自增，整数，不能为空
chapter_id，整数，第几章
chapter_title，可变长字符，VARCHAR(255)，章标题
chapter_text，长文本, MEDIUMTEXT，学习内容
chapter_image，可变长字符，VARCHAR(255)，学习内容的封面图片
hits，整数，学习内容的点击数，有用户阅读 1 次，就增加 1*/
    private Integer id;
    private Integer chapterId;
    private String chapterTitle;
    private String chapterText;
    private String chapterImage;
    private Integer hits;

    public String myname() {
        return "张广福-2021110890 邹明道-2021110896 蒋华培-2021110836";
    }

    public Content() {
    }

    public Content(Integer chapterId, String chapterTitle, String chapterText, String chapterImage, Integer hits) {
        this.chapterId = chapterId;
        this.chapterTitle = chapterTitle;
        this.chapterText = chapterText;
        this.chapterImage = chapterImage;
        this.hits = hits;
    }

    public Content(Integer id, Integer chapterId, String chapterTitle, String chapterText, String chapterImage, Integer hits) {
        this.id = id;
        this.chapterId = chapterId;
        this.chapterTitle = chapterTitle;
        this.chapterText = chapterText;
        this.chapterImage = chapterImage;
        this.hits = hits;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getChapterId() {
        return chapterId;
    }

    public void setChapterId(Integer chapterId) {
        this.chapterId = chapterId;
    }

    public String getChapterTitle() {
        return chapterTitle;
    }

    public void setChapterTitle(String chapterTitle) {
        this.chapterTitle = chapterTitle;
    }

    public String getChapterText() {
        return chapterText;
    }

    public void setChapterText(String chapterText) {
        this.chapterText = chapterText;
    }

    public String getChapterImage() {
        return chapterImage;
    }

    public void setChapterImage(String chapterImage) {
        this.chapterImage = chapterImage;
    }

    public Integer getHits() {
        return hits;
    }

    public void setHits(Integer hits) {
        this.hits = hits;
    }

    @Override
    public String toString() {
        return "Content{" +
                "id=" + id +
                ", chapterId=" + chapterId +
                ", chapterTitle='" + chapterTitle + '\'' +
                ", chapterText='" + chapterText + '\'' +
                ", chapterImage='" + chapterImage + '\'' +
                ", hits=" + hits +
                '}';
    }
}
