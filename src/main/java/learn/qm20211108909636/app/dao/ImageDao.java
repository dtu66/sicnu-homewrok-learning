package learn.qm20211108909636.app.dao;

import learn.qm20211108909636.app.entity.Image;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface ImageDao {

    /**
     * 作者：2021110890 张广福
     * 保存图片
     * @param image
     * @return
     */
    @Insert("INSERT INTO image (path, base64) VALUES (#{path}, #{base64})")
    int saveImage(Image image);

    /**
     * 作者：2021110890 张广福
     * 更新图片
     * @param image
     * @return
     */
    @Update("UPDATE image SET path = #{path}, base64 = #{base64} WHERE path = #{path}")
    int updateImage(Image image);

    /**
     * 作者：2021110890 张广福
     * 删除图片
     * @param id
     * @return
     */
    @Select("SELECT * FROM image WHERE id = #{id}")
    Image getImageById(int id);

    /**
     * 作者：2021110890 张广福
     * 通过路径获取图片
     * @param path
     * @return
     */
    @Select("SELECT * FROM image WHERE path = #{path}")
    Image getImageByPath(String path);
}
