package ucad.sn.sociale_service.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
@NoArgsConstructor @AllArgsConstructor @Builder @Getter @Setter
public class DeclarationRequest {
    protected String titre;
    protected String description;
    protected String demandeurId;
    protected List<MultipartFile> images;
}
