package ucad.sn.gestiondonservice.dto;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter
public class DonMaterielRequest extends DonRequest{
    private String titre;
    private String description;
    private List<MultipartFile> imagesDon;

}
