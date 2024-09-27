package ucad.sn.gestiondonservice.mappers;

import org.springframework.stereotype.Component;
import ucad.sn.gestiondonservice.services.ImageService;

@Component
public class DonMapper {
    ImageService imageService;

    public DonMapper(ImageService imageService) {
        this.imageService = imageService;
    }
}
