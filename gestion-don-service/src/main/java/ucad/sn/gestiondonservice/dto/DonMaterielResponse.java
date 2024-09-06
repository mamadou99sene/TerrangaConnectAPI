package ucad.sn.gestiondonservice.dto;

import lombok.*;
import java.util.List;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter
public class DonMaterielResponse extends DonResponse{
    private String titre;
    private String description;
    private List<String> imagesDon;


}
