package ucad.sn.gestiondonservice.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ucad.sn.gestiondonservice.entities.DonSang;

import java.util.List;

@Repository
public interface DonSangRepository extends JpaRepository<DonSang, String> {
    List<DonSang> findDonSangsByDeclarationId(String declarationId);
}
