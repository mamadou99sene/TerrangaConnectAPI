package ucad.sn.sociale_service.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ucad.sn.sociale_service.entities.DemandeDondeSang;
import ucad.sn.sociale_service.enums.StatusDeclaration;

import java.util.List;

@Repository
public interface DemandeDondeSangRepository extends JpaRepository<DemandeDondeSang, String> {
    List<DemandeDondeSang> findByStatusOrderByDatePublicationDesc(StatusDeclaration status);
}
