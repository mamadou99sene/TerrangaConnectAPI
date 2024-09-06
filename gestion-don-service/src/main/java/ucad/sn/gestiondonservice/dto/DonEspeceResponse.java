package ucad.sn.gestiondonservice.dto;

import lombok.*;
import ucad.sn.gestiondonservice.enums.TypeDon;

import java.time.LocalDateTime;
import java.util.List;

@NoArgsConstructor @AllArgsConstructor  @Getter @Setter
public class DonEspeceResponse extends DonResponse{
    private double montant;
}
