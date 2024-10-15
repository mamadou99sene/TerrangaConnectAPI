package ucad.sn.sociale_service.dto;

import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
@NoArgsConstructor @AllArgsConstructor @Builder @Getter @Setter
@FieldDefaults(level = AccessLevel.PROTECTED)
public class DeclarationRequest {
     String titre;
     String description;
     String demandeurId;
     List<MultipartFile> images;
}
