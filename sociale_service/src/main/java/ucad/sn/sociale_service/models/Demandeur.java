package ucad.sn.sociale_service.models;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter @NoArgsConstructor
public class Demandeur {
    private String id;
    private String email;
    private String telephone;
    private double score;
    private String profile;
}
