package ucad.sn.sociale_service.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ucad.sn.sociale_service.entities.Evenement;
import ucad.sn.sociale_service.enums.StatusDeclaration;

import java.util.List;

@Repository
public interface EvenementRepository extends JpaRepository<Evenement, String> {

    List<Evenement> findByStatusOrderByDatePublicationDesc(StatusDeclaration status);
}
