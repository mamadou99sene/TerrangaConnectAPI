package ucad.sn.gestiondonservice.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.gestiondonservice.enums.TypeDon;

import java.util.List;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter
public class DonEspeceRequest extends DonRequest{
    private double montant;

}
