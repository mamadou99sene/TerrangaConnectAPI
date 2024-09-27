package ucad.sn.sociale_service.dto;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import ucad.sn.sociale_service.enums.TypeEvenement;

import java.time.LocalDateTime;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter
public class EvenementRequest extends DeclarationRequest{
    private String lieu;
    private TypeEvenement type;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSS")
    private LocalDateTime dateDebut;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSS")
    private LocalDateTime dateFin;


}
