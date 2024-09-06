package ucad.sn.gestiondonservice.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ucad.sn.gestiondonservice.entities.DonEspece;

import java.util.List;

@Repository
public interface DonEspeceRepository extends JpaRepository<DonEspece, String> {
    List<DonEspece> findDonEspecesByDeclarationId(String declarationId);
}
