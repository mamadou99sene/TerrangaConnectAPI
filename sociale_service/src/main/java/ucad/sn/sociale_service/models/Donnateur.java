package ucad.sn.sociale_service.models;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ucad.sn.sociale_service.enums.TypeDonnateur;
@Getter
@Setter
@NoArgsConstructor
public class Donnateur {
    private String id;
    private String email;
    private String telephone;
    private double score;
    private TypeDonnateur type;
}
