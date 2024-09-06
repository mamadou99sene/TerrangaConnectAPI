package ucad.sn.sociale_service.clients;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import ucad.sn.sociale_service.models.Don;

import java.util.List;

@FeignClient("gestion-dons-service")
public interface DonRestClient {
    @GetMapping
    List<Don> findAllDonsByDeclarationId(@PathVariable String idDeclaration);
}
