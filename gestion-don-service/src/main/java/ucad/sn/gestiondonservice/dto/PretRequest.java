package ucad.sn.gestiondonservice.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.gestiondonservice.enums.TypeDon;

import java.util.List;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter
public class PretRequest extends DonRequest{
    private String titre;
    private String description;
    private int duree;
    protected List<MultipartFile> images;
}
