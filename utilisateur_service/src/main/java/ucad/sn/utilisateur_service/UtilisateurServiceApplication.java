package ucad.sn.utilisateur_service;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import ucad.sn.utilisateur_service.dto.UtilisateurRequest;
import ucad.sn.utilisateur_service.entities.Demandeur;
import ucad.sn.utilisateur_service.entities.Utilisateur;
import ucad.sn.utilisateur_service.enums.Role;
import ucad.sn.utilisateur_service.repositories.UtilisateurRepository;
import ucad.sn.utilisateur_service.services.UtilisateurService;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@SpringBootApplication
public class UtilisateurServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(UtilisateurServiceApplication.class, args);
    }
    //@Bean
    CommandLineRunner commandLineRunner(UtilisateurService utilisateurService)
    {
        return args -> {
            List<UtilisateurRequest> listUser =new ArrayList<>(Arrays.asList(
                    UtilisateurRequest.builder()
                            .email("senemamadou1999@gmail.com")
                            .telephone("778340335")
                            .score(10)
                            .password("Senemomo")
                            .roles(List.of(Role.USER, Role.MODERATEUR))
                            .build(),
                    UtilisateurRequest.builder()
                            .email("moussa@gmail.com")
                            .telephone("768900091")
                            .score(11)
                            .password("passer")
                            .roles(List.of(Role.USER))
                            .build(),
                    UtilisateurRequest.builder()
                            .email("idrissa@gmail.com")
                            .telephone("779090000")
                            .score(12)
                            .password("passer")
                            .roles(List.of(Role.USER))
                            .build()
            ));
            utilisateurService.createListOfUser(listUser);
        };
    }
}
