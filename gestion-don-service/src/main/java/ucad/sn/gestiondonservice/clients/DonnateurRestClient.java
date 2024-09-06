package ucad.sn.gestiondonservice.clients;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import ucad.sn.gestiondonservice.models.Donnateur;

@FeignClient(name = "utilisateur-service")
public interface DonnateurRestClient {
    @GetMapping("/api/utilisateurs/{idDonateur}")
    Donnateur getDonnateurById(@PathVariable String idDonateur);
}
