package ucad.sn.utilisateur_service.entities;

import jakarta.persistence.Entity;
import lombok.*;

@Entity
@NoArgsConstructor @AllArgsConstructor @Getter @Setter
public class Demandeur  extends Utilisateur{
    private String adresse;
}
