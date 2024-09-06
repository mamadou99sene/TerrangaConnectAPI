package ucad.sn.gestiondonservice.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter
public class PretResponse extends DonResponse{
    private String titre;
    private String description;
    private int duree;
    protected List<String> images;
}
