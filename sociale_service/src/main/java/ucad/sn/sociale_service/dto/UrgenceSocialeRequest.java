package ucad.sn.sociale_service.dto;

import lombok.*;
import ucad.sn.sociale_service.enums.TypeUrgence;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter
public class UrgenceSocialeRequest extends DeclarationRequest{
    private String lieu;
    private TypeUrgence type;
    private double montantRequis;


}
