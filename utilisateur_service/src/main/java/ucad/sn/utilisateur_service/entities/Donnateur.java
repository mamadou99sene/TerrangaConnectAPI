package ucad.sn.utilisateur_service.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.*;
import lombok.experimental.FieldDefaults;
import ucad.sn.utilisateur_service.enums.TypeDonnateur;

@Entity
@NoArgsConstructor @AllArgsConstructor @Getter @Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Donnateur extends Utilisateur{
    @Enumerated(value = EnumType.STRING)
     TypeDonnateur type;
}
