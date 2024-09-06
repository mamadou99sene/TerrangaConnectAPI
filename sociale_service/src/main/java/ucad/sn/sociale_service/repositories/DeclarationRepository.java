package ucad.sn.sociale_service.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ucad.sn.sociale_service.entities.Declaration;

@Repository
public interface DeclarationRepository extends JpaRepository<Declaration, String> {
}
