package learn.qm20211108909636.app.controller;

import jakarta.servlet.http.HttpSession;
import learn.qm20211108909636.app.Enum.StatusCode;
import learn.qm20211108909636.app.entity.Image;
import learn.qm20211108909636.app.entity.Userinfo;
import learn.qm20211108909636.app.service.ImageService;
import learn.qm20211108909636.app.utils.ResultUtil;
import learn.qm20211108909636.app.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/image")
public class ImageController {

    @Autowired
    private ImageService imageService;

    // 图片上传接口
    @PostMapping("/upload")
    public String uploadImage(@RequestBody Map<String,String> map , HttpSession session) {
        Userinfo userinfo = (Userinfo) session.getAttribute("user");
        if (userinfo == null) {
            return ResultUtil.error();
        }

        String path = StringUtil.isEmpty(map.get("path")) ? null : map.get("path");

        String base64 = map.get("base64");

        if (path == null || base64 == null || base64.length() < 255) {
            return ResultUtil.error();
        }

        Image image = new Image();
        image.setPath(path);
        image.setBase64(base64);


        // 保存图片信息到数据库
        int i = imageService.uploadImage(image);

        if (i > 0) {
            return ResultUtil.success(path);
        }
        return ResultUtil.error();
    }

//    // 访问图片接口
//    @GetMapping("/{id}")
//    public ResponseEntity<Image> getImage(@PathVariable("id") int id) {
//        Image image = imageService.getImage(id);
//        if (image != null) {
//            return ResponseEntity.ok(image);
//        } else {
//            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
//        }
//    }

    @GetMapping("/{path}")
    public String getImageByPath(@PathVariable("path") String path) {
        System.out.println(path);
        Image image = imageService.getImage(path);
        if (image != null) {
            return ResultUtil.success(image);
        } else {
            return ResultUtil.error(StatusCode.NOT_FOUND);
        }
    }

    @GetMapping("/profile/{path}")
    public String getProfileImageByPath(@PathVariable("path") String path) {
        Image image = imageService.getImage("/profile/"+path);
        if (image != null) {
            return ResultUtil.success(image);
        } else {
            return ResultUtil.error(StatusCode.NOT_FOUND);
        }
    }

    @GetMapping("/cover/{path}")
    public String getCoverImageByPath(@PathVariable("path") String path) {
        Image image = imageService.getImage("/cover/"+path);
        if (image != null) {
            return ResultUtil.success(image);
        } else {
            return ResultUtil.error(StatusCode.NOT_FOUND);
        }
    }
}
