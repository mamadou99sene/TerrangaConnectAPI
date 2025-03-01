package ucad.sn.utilisateur_service.services.implementation;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.utilisateur_service.services.ProfilService;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;
@Service
public class ProfilServiceImpl implements ProfilService {
    private final Path rootPath= Paths.get("./ucad/sn/sociale_service/ProfileImages");
    public ProfilServiceImpl() {
        try {
            Files.createDirectories(rootPath);
        } catch (IOException e) {
            throw new RuntimeException("Could not create directory for images");
        }
    }
    public String saveImage(MultipartFile file) {
        if (file.isEmpty()) {
            throw new RuntimeException("Failed to store empty file");
        }

        String filename = UUID.randomUUID() + "_" + file.getOriginalFilename();
        Path destinationFile = rootPath.resolve(Paths.get(filename)).normalize().toAbsolutePath();
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
            Path file=rootPath.resolve(filename);
            Files.deleteIfExists(file);
            return true;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public Resource loadImage(String filename) {
        try {
            Path file = rootPath.resolve(filename);
            Resource resource = new UrlResource(file.toUri());
            if (resource.exists() || resource.isReadable()) {
                return resource;
            } else {
                throw new RuntimeException("Failed to read file: " + filename);
            }
        } catch (MalformedURLException e) {
            throw new RuntimeException("Failed to load image", e);
        }
    }
}
