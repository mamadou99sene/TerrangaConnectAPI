package ucad.sn.gestiondonservice.services;

import org.springframework.web.multipart.MultipartFile;

public interface ImageService {
    public String saveImage(MultipartFile file);
    public Boolean deleteImage(String url);
}
