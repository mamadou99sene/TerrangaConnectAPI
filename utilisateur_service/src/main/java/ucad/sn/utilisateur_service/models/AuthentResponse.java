package ucad.sn.utilisateur_service.models;

import lombok.*;
import ucad.sn.utilisateur_service.enums.Role;

import java.util.List;

@AllArgsConstructor @NoArgsConstructor @Getter @Setter @Builder
public class AuthentResponse {
        private String accessToken;
        private String refreshToken;
        private String utilisateurId;
        private List<Role> roles;
}

