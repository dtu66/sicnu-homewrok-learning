package learn.qm20211108909636.app.service.impl;

import learn.qm20211108909636.app.dao.ImageDao;
import learn.qm20211108909636.app.entity.Image;
import learn.qm20211108909636.app.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ImageServiceImpl implements ImageService {

    @Autowired
    private ImageDao imageDao;

    @Transactional
    @Override
    public int uploadImage(Image image) {
        // 查重
        Image image1 = imageDao.getImageByPath(image.getPath());
        if (image1 != null) {
            return imageDao.updateImage(image);
        }
        return imageDao.saveImage(image);
    }

    @Override
    public Image getImage(int id) {
        return imageDao.getImageById(id);
    }

    @Override
    public Image getImage(String path) {
        return imageDao.getImageByPath(path);
    }
}
