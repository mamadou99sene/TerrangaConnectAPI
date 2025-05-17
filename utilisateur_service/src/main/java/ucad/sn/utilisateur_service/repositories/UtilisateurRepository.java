package ucad.sn.utilisateur_service.repositories;

import jakarta.annotation.Nullable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ucad.sn.utilisateur_service.entities.Utilisateur;

import java.util.Optional;

@Repository

public interface UtilisateurRepository extends JpaRepository<Utilisateur, String> {
    @Nullable
    Utilisateur findByEmail(String email);
    Optional<Utilisateur> findByKeycloakId(String keycloakId);
}
