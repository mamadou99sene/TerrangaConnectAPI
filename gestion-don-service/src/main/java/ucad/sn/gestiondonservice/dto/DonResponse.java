package ucad.sn.gestiondonservice.dto;

import lombok.*;
import ucad.sn.gestiondonservice.enums.TypeDon;
import ucad.sn.gestiondonservice.models.Donnateur;

import java.time.LocalDateTime;

@NoArgsConstructor @AllArgsConstructor @Builder @Getter @Setter
public class DonResponse {
    private String id;
    private LocalDateTime datePublication;
    private TypeDon type;
    private String declarationId;
    private String donateurId;
    private Donnateur donnateur;
}
