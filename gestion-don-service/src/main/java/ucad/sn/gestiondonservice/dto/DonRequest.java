package ucad.sn.gestiondonservice.dto;

import lombok.*;
import ucad.sn.gestiondonservice.enums.TypeDon;
@NoArgsConstructor @AllArgsConstructor @Builder @Getter @Setter
public class DonRequest {
    protected TypeDon type;
    protected String declarationId;
    protected String donateurId;
}
