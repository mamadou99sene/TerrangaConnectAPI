package ucad.sn.utilisateur_service.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ucad.sn.utilisateur_service.entities.Demandeur;
import ucad.sn.utilisateur_service.services.DemandeurService;

import java.util.List;

@RestController
@RequestMapping("/api")
public class DemandeurController {
    private DemandeurService demandeurService;

    public DemandeurController(DemandeurService demandeurService) {
        this.demandeurService = demandeurService;
    }
    @GetMapping("/demandeurs")
    public ResponseEntity<List<Demandeur>> getAllDemandeurs()
    {
        List<Demandeur> allDemandeurs = this.demandeurService.getAllDemandeurs();
        return ResponseEntity.status(HttpStatus.OK).body(allDemandeurs);
    }
    @GetMapping("/demandeurs/{id}")
    public ResponseEntity<Demandeur> getDemandeurbyId(@PathVariable String id)
    {
        Demandeur demandeur = this.demandeurService.getdemandeurById(id);
        return ResponseEntity.status(HttpStatus.OK).body(demandeur);
    }
    @PostMapping("/demandeurs")
    public ResponseEntity<Demandeur> saveDemandeur(@RequestBody Demandeur demandeur)
    {
        Demandeur saved = this.demandeurService.saveDemandeur(demandeur);
        return ResponseEntity.status(HttpStatus.CREATED).body(saved);
    }
}
