package learn.qm20211108909636.app.service;

import learn.qm20211108909636.app.entity.Image;

public interface ImageService {
    int uploadImage(Image image);
    Image getImage(int id);
    Image getImage(String path);
}
