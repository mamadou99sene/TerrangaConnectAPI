package ucad.sn.gestiondonservice.services.implementation;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.gestiondonservice.services.ImageService;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Service
public class ImageServiceImpl implements ImageService {
    private final Path rootPath;
    private final String imageUrlPrefix;

    public ImageServiceImpl(@Value("${app.upload.dir}") String uploadDir,
                            @Value("${app.image.url.prefix}") String imageUrlPrefix) {
        this.rootPath = Paths.get(uploadDir).toAbsolutePath().normalize();
        this.imageUrlPrefix = imageUrlPrefix;
        try {
            Files.createDirectories(this.rootPath);
        } catch (IOException e) {
            throw new RuntimeException("Could not create directory for images", e);
        }
    }

    @Override
    public String saveImage(MultipartFile file) {
        if (file.isEmpty()) {
            throw new RuntimeException("Failed to store empty file");
        }
        String filename = UUID.randomUUID() + "_" + file.getOriginalFilename();
        Path destinationFile = this.rootPath.resolve(filename).normalize();
        try {
            Files.copy(file.getInputStream(), destinationFile);
        } catch (IOException e) {
            throw new RuntimeException("Failed to store file", e);
        }
        return filename;
    }

    @Override
    public Boolean deleteImage(String filename) {
        try {
            Path file = this.rootPath.resolve(filename);
            return Files.deleteIfExists(file);
        } catch (IOException e) {
            throw new RuntimeException("Failed to delete file", e);
        }
    }

    @Override
    public String getImageUrl(String filename) {
        return this.imageUrlPrefix + filename;
    }
}
