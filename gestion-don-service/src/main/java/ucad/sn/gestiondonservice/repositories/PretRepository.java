package ucad.sn.gestiondonservice.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ucad.sn.gestiondonservice.entities.Pret;

import java.util.List;

@Repository
public interface PretRepository extends JpaRepository<Pret, String> {
    List<Pret> findPretsByDeclarationId(String declarationId);
}
