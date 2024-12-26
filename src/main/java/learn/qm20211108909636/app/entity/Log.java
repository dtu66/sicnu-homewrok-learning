package learn.qm20211108909636.app.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@TableName("log")
public class Log implements Serializable {
    /*
    * log
log 表有 4 个字段
id，主键，自增，整数，不能为空
user_id，整数，用户 id
content_id，整数，内容 id
optime，时间（DATETIME 或者 BIGINT(13)），记录日志产生时间*/
    private Integer id;
    private Integer userId;
    private Integer contentId;
    private Date opTime;


    public String myname() {
        return "张广福-2021110890 邹明道-2021110896 蒋华培-2021110836";
    }

    public Log() {
    }

    public Log(Integer userId, Integer contentId, Date opTime) {
        this.userId = userId;
        this.contentId = contentId;
        this.opTime = opTime;
    }

    public Log(Integer id, Integer userId, Integer contentId, Date opTime) {
        this.id = id;
        this.userId = userId;
        this.contentId = contentId;
        this.opTime = opTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getContentId() {
        return contentId;
    }

    public void setContentId(Integer contentId) {
        this.contentId = contentId;
    }

    public Date getOpTime() {
        return opTime;
    }

    public void setOpTime(Date opTime) {
        this.opTime = opTime;
    }

    @Override
    public String toString() {
        return "Log{" +
                "id=" + id +
                ", userId=" + userId +
                ", contentId=" + contentId +
                ", opTime=" + opTime +
                '}';
    }
}
