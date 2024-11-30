package ucad.sn.sociale_service.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ucad.sn.sociale_service.entities.UrgenceSociale;
import ucad.sn.sociale_service.enums.StatusDeclaration;

import java.util.List;

@Repository
public interface UrgenceSocialeRepository extends JpaRepository<UrgenceSociale, String> {
    List<UrgenceSociale> findByStatusOrderByDatePublicationDesc(StatusDeclaration status);
}
