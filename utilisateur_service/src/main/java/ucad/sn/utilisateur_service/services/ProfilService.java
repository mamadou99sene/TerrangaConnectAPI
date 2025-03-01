package ucad.sn.utilisateur_service.services;

import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;

public interface ProfilService {
    public String saveImage(MultipartFile file);
    public Boolean deleteImage(String url);
    public Resource loadImage(String filename);
}
