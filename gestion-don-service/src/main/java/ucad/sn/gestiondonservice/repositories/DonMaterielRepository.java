package ucad.sn.gestiondonservice.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ucad.sn.gestiondonservice.entities.DonMateriel;

import java.util.List;

@Repository
public interface DonMaterielRepository extends JpaRepository<DonMateriel, String> {
    List<DonMateriel> findDonMaterielsByDeclarationId(String declarationId);
}
