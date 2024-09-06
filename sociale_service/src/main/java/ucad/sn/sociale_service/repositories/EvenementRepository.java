package ucad.sn.sociale_service.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ucad.sn.sociale_service.entities.Evenement;
@Repository
public interface EvenementRepository extends JpaRepository<Evenement, String> {
}
