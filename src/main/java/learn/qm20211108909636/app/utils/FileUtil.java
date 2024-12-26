package learn.qm20211108909636.app.utils;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

public class FileUtil {
    /**
     * 保存上传的文件，并返回文件的URL路径
     * @param file MultipartFile 文件对象
     * @param uploadDirectory 存储文件的目录
     * @return 文件的URL路径
     * @throws IOException 如果文件处理失败
     */
    public static String saveFile(MultipartFile file, String uploadDirectory) throws IOException {
        // 确保上传目录存在
        Path directoryPath = Paths.get(uploadDirectory);
        File directory = directoryPath.toFile();
        if (!directory.exists()) {
            directory.mkdirs();
        }

        // 生成唯一的文件名，避免文件冲突
        String fileName = UUID.randomUUID().toString() + "-" + file.getOriginalFilename();
        File destFile = new File(uploadDirectory, fileName);

        // 使用 Commons IO 保存文件
        FileUtils.copyInputStreamToFile(file.getInputStream(), destFile);

        // 返回文件的相对路径
        return "/uploads/" + fileName;
    }

    /**
     * 删除服务器上的文件
     * @param filePath 文件的路径
     * @return 是否成功删除
     */
    public static boolean deleteFile(String filePath) {
        File file = new File(filePath);
        return file.exists() && file.delete();
    }
}
