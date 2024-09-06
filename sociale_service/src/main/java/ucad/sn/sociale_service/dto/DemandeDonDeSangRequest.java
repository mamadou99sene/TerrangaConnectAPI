package ucad.sn.sociale_service.dto;

import lombok.*;
import ucad.sn.sociale_service.enums.ClasseSang;
import ucad.sn.sociale_service.enums.Rhesus;

@NoArgsConstructor @AllArgsConstructor @Getter @Setter
public class DemandeDonDeSangRequest extends DeclarationRequest{
    private String adresse;
    private ClasseSang classe;
    private Rhesus rhesus;

}
