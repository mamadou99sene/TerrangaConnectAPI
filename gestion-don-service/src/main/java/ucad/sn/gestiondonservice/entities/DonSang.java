package ucad.sn.gestiondonservice.entities;

import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter @Setter @NoArgsConstructor
public class DonSang extends Don{
    private String adresseDonnateur;
}
