package ucad.sn.utilisateur_service.entities;

import jakarta.persistence.Entity;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@NoArgsConstructor @AllArgsConstructor @Getter @Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Demandeur  extends Utilisateur{
     String adresse;
}
