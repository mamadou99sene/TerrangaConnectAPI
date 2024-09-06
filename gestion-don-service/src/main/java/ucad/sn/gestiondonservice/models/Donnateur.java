package ucad.sn.gestiondonservice.models;

import lombok.*;

@Getter @Setter @Builder @NoArgsConstructor @AllArgsConstructor
public class Donnateur {
    private String id;
    private String email;
    private String telephone;
    private double score;
}
