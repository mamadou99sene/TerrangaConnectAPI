package ucad.sn.utilisateur_service.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ucad.sn.utilisateur_service.dto.UtilisateurRequest;
import ucad.sn.utilisateur_service.entities.Utilisateur;
import ucad.sn.utilisateur_service.services.UtilisateurService;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
public class UtilisateurController {
    private UtilisateurService utilisateurService;

    public UtilisateurController(UtilisateurService utilisateurService) {
        this.utilisateurService = utilisateurService;
    }

    @GetMapping("/utilisateurs")
    ResponseEntity <List<Utilisateur>> getAllUtilisateurs(){
        List<Utilisateur> utilisateurs = this.utilisateurService.
                getAllUtilisateurs().
                stream().
                collect(Collectors.toList());
        return  ResponseEntity.status(HttpStatus.OK).body(utilisateurs);
    }
    @GetMapping("/utilisateurs/{id}")
    ResponseEntity  <Utilisateur> getUtilisateurById(@PathVariable String id)
    {
        Utilisateur utilisateurById = utilisateurService.getUtilisateurById(id);
        if(utilisateurById!=null)
        {
            return ResponseEntity.status(HttpStatus.OK).body(utilisateurById);
        }
        throw new RuntimeException("Utilisateur non trouvé");
    }

    @PutMapping("/utilisateurs/{id}")
    ResponseEntity <Utilisateur> updateutilisateur(@RequestBody UtilisateurRequest utilisateur, @PathVariable String id)
    {
        Utilisateur utilisateurById = this.utilisateurService.getUtilisateurById(id);
        if (utilisateurById!=null)
        {
            utilisateurById = this.utilisateurService.updateutilisateur(utilisateur, id);
            return ResponseEntity.status(HttpStatus.CREATED).body(utilisateurById);
        }
        throw new RuntimeException("Utilisateur non trouvé");
    }
    @DeleteMapping("/utilisateurs/{id}")
    ResponseEntity<Boolean> deleteUtilisateur(@PathVariable String id)
    {
        Utilisateur utilisateur=this.utilisateurService.getUtilisateurById(id);
        if(utilisateur!=null)
        {
            boolean deleted = this.utilisateurService.deleteUtilisateur(id);
            return ResponseEntity.status(HttpStatus.OK).body(deleted);
        }
        throw new RuntimeException("La suppression ne concerne aucun utilisateur");
    }
@PostMapping("/utilisateurs/register")
    ResponseEntity<Utilisateur> createUtilisateur(@RequestBody UtilisateurRequest utilisateur)
    {
        Utilisateur createdUser = this.utilisateurService.createUtilisateur(utilisateur);
        return  ResponseEntity.status(HttpStatus.CREATED).body(createdUser);
    }
}
