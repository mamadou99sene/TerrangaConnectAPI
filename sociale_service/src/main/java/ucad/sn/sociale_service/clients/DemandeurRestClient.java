package ucad.sn.sociale_service.clients;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import ucad.sn.sociale_service.models.Demandeur;

@FeignClient("utilisateur-service")
public interface DemandeurRestClient {
    @GetMapping("/api/utilisateurs/{id}")

    public Demandeur findUtilisateurById( @PathVariable String id);
}
