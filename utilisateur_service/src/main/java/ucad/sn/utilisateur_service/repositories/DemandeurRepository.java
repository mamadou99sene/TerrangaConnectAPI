package ucad.sn.utilisateur_service.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ucad.sn.utilisateur_service.entities.Demandeur;
@Repository
public interface DemandeurRepository extends JpaRepository<Demandeur, String> {
}
