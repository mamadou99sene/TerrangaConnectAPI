package ucad.sn.sociale_service.dto;

import lombok.*;
import ucad.sn.sociale_service.enums.StatusDeclaration;
import ucad.sn.sociale_service.models.Demandeur;

import java.time.LocalDateTime;
import java.util.List;

@NoArgsConstructor @AllArgsConstructor @Builder @Getter @Setter
public class DeclarationResponse {
    private String id;
    private String titre;
    private String description;
    private Demandeur demandeur;
    private String demandeurId;
    private LocalDateTime datePublication;
    private StatusDeclaration status;
    private List<String> images;
}
