package ucad.sn.utilisateur_service.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ucad.sn.utilisateur_service.entities.Utilisateur;
@Repository

public interface UtilisateurRepository extends JpaRepository<Utilisateur, String> {
}
