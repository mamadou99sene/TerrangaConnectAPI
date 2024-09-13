package ucad.sn.sociale_service.services.implementation;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.sociale_service.services.ImageService;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Service
public class ImageServiceImpl implements ImageService {
    private final Path rootPath= Paths.get("C:\\Users\\FIS-TS\\IdeaProjects\\TerangaConnectAPI\\sociale_service\\src\\main\\resources\\static\\MesImages");
    public ImageServiceImpl() {
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
}
