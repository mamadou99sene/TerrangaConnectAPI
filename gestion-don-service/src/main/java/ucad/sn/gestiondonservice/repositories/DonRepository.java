package ucad.sn.gestiondonservice.repositories;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ucad.sn.gestiondonservice.entities.Don;
@Repository
public interface DonRepository extends JpaRepository<Don,String> {
}
