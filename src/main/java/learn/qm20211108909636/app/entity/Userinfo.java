package learn.qm20211108909636.app.entity;

import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;

@TableName("userinfo")
public class Userinfo implements Serializable {
    /*
    * userinfo 表有 5 个字段分别为
id，主键，自增，整数，不能为空
username，可变长度字符，20 位
password，可变长度字符，32 位
role,可变长的字符，10 位
head_image，可变长字符，VARCHAR(255)，用户的头像图片
stu110599，可变长度字符，20 位（字符名称按自己学号修改*/
    private Integer id;
    private String username;
    private String password;
    private String role;
    private String headImage;
    private String stu20211108909636;


    public String myname() {
        return "张广福-2021110890 邹明道-2021110896 蒋华培-2021110836";
    }

    public Userinfo() {
    }

    public Userinfo(String username, String password, String role, String headImage, String stu20211108909636) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.headImage = headImage;
        this.stu20211108909636 = stu20211108909636;
    }

    public Userinfo(Integer id, String username, String password, String role, String headImage, String stu20211108909636) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.role = role;
        this.headImage = headImage;
        this.stu20211108909636 = stu20211108909636;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getHeadImage() {
        return headImage;
    }

    public void setHeadImage(String headImage) {
        this.headImage = headImage;
    }

    public String getStu20211108909636() {
        return stu20211108909636;
    }

    public void setStu20211108909636(String stu20211108909636) {
        this.stu20211108909636 = stu20211108909636;
    }

    @Override
    public String toString() {
        return "Userinfo{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", role='" + role + '\'' +
                ", headImage='" + headImage + '\'' +
                ", stu20211108909636='" + stu20211108909636 + '\'' +
                '}';
    }
}
