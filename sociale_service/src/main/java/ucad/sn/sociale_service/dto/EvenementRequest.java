package ucad.sn.sociale_service.dto;

import lombok.*;
import ucad.sn.sociale_service.enums.TypeEvenement;

import java.time.LocalDateTime;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter
public class EvenementRequest extends DeclarationRequest{
    private String lieu;
    private TypeEvenement type;
    private LocalDateTime dateDebut;
    private LocalDateTime dateFin;


}
