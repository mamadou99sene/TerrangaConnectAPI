package ucad.sn.sociale_service.clients;

import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import io.github.resilience4j.retry.annotation.Retry;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import ucad.sn.sociale_service.models.Demandeur;

@FeignClient("utilisateur-service")
public interface DemandeurRestClient {
    @GetMapping("/api/utilisateurs/{id}")
    @CircuitBreaker(name = "UtilisateurDeclaration",fallbackMethod = "getCachedUtilisateur")
    @Retry(name = "retrySearchUtilisateur",fallbackMethod = "getCachedUtilisateur")
    @Cacheable(value = "utilisateurById", key = "#id")
    public Demandeur findUtilisateurById( @PathVariable String id);
    default Demandeur getCachedUtilisateur(String id, Exception e)
    {
        Demandeur demandeur=new Demandeur();
        demandeur.setId(id);
        demandeur.setEmail("availaible");
        demandeur.setScore(0);
        demandeur.setProfile("undefine");
        demandeur.setTelephone("undefine");
        return demandeur;
    }
}
