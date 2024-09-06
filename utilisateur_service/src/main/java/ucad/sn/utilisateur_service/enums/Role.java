package ucad.sn.utilisateur_service.enums;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

public enum Role {
    USER,
    PARTENAIRE,
    MODERATEUR,
    ADMIN;
}
