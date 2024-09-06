package ucad.sn.utilisateur_service.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.*;
import ucad.sn.utilisateur_service.enums.TypeDonnateur;

@Entity
@NoArgsConstructor @AllArgsConstructor @Getter @Setter

public class Donnateur extends Utilisateur{
    @Enumerated(value = EnumType.STRING)
    private TypeDonnateur type;
}
