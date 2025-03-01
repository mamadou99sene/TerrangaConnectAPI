package ucad.sn.utilisateur_service.models;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

@AllArgsConstructor @NoArgsConstructor @Getter @Setter @Builder
public class AuthentRequest {
        @Email
        @NotBlank
        private String email;
        @NotBlank
        private String password;
}

