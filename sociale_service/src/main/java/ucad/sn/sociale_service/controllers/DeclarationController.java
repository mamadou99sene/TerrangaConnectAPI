package ucad.sn.sociale_service.controllers;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.sociale_service.dto.*;
import ucad.sn.sociale_service.services.DeclarationService;

import java.util.List;

@RestController
@RequestMapping("/api")
public class DeclarationController {
    private final DeclarationService declarationService;
    private final Logger logger = LoggerFactory.getLogger(DeclarationController.class);

    public DeclarationController(DeclarationService declarationService) {
        this.declarationService = declarationService;
    }
    @GetMapping("/declarations/urgence")
    public ResponseEntity<List<UrgenceSocialeResponse>> getAllUrgenceDeclaration()
    {
        List<UrgenceSocialeResponse> responseList=this.declarationService.getAllUrgenceDeclaration();
        return ResponseEntity.status(HttpStatus.OK).body(responseList);
    }

    @GetMapping("/declarations/donSang")
    public ResponseEntity<List<DemandeDonDeSangResponse>> getAllDemandedonSangDeclaration()
    {
        List<DemandeDonDeSangResponse> responseList=this.declarationService.getAllDemandeDonDeclaration();
        return ResponseEntity.status(HttpStatus.OK).body(responseList);
    }

    @GetMapping("/declarations/event")
    public ResponseEntity<List<EvenementResponse>> getAllEventDeclaration()
    {
        List<EvenementResponse> responseList=this.declarationService.getAllEventDeclaration();
        return ResponseEntity.status(HttpStatus.OK).body(responseList);
    }
    @PostMapping("/declarations/urgence")
    public ResponseEntity<UrgenceSocialeResponse> saveUrgenceDeclaration(@ModelAttribute UrgenceSocialeRequest declarationRequest,
                                                               @RequestParam("images") List<MultipartFile> files)
    {
        logger.info("Received declaration request: {}", declarationRequest.getDemandeurId());
        logger.info("Received {} images", files.size());
        UrgenceSocialeResponse response = this.declarationService.saveUrgenceDeclaration(declarationRequest, files);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
    @PostMapping("/declarations/donSang")
    public ResponseEntity<Object> saveDemandeDondeSangDeclaration(@ModelAttribute DemandeDonDeSangRequest declarationRequest,
                                                  @RequestParam("images") List<MultipartFile> files)
    {
        logger.info("Received declaration request: {}", declarationRequest.getDemandeurId());
        logger.info("Received {} images", files.size());
        DemandeDonDeSangResponse response = this.declarationService.saveDemandeDonDeclaration(declarationRequest, files);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
    @PostMapping("/declarations/event")
    public ResponseEntity<EvenementResponse> saveEventDeclaration(@ModelAttribute EvenementRequest declarationRequest,
                                                  @RequestParam("images") List<MultipartFile> files)
    {
        logger.info("Received declaration request: {}", declarationRequest.getDemandeurId());
        logger.info("Received {} images", files.size());
        EvenementResponse response = this.declarationService.saveEventDeclaration(declarationRequest, files);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
    @GetMapping("/declarations/urgence/{idDeclaration}")
    public ResponseEntity<UrgenceSocialeResponse> getDeclaratonUrgenceByid(@PathVariable String idDeclaration)
    {
        UrgenceSocialeResponse response=this.declarationService.getUrgenceDeclarationById(idDeclaration);
        if(response==null)
        {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }
    @GetMapping("/declarations/donSang/{idDeclaration}")
    public ResponseEntity<DemandeDonDeSangResponse> getDeclaratonDemandedonSangByid(@PathVariable String idDeclaration)
    {
        DemandeDonDeSangResponse response=this.declarationService.getDemandeDeclarationById(idDeclaration);
        if(response==null)
        {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }
    @GetMapping("/declarations/event/{idDeclaration}")
    public ResponseEntity<EvenementResponse> getDeclaratonEventByid(@PathVariable String idDeclaration)
    {
        EvenementResponse response=this.declarationService.getEventDeclarationById(idDeclaration);
        if(response==null)
        {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.status(HttpStatus.OK).body(response);
    }
    @PutMapping("/declarations/{id}")
    public ResponseEntity<DeclarationResponse> updateDeclaration(@RequestBody DeclarationRequest request, @PathVariable String id)
    {
        DeclarationResponse response=this.declarationService.updateDeclaration(request,id);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
@DeleteMapping("/declarations/{idDeclaration}")
    public ResponseEntity<Boolean> deleteDeclaration(@PathVariable String idDeclaration)
    {
        Boolean isDeleted = this.declarationService.deleteDeclaration(idDeclaration);
        if(isDeleted)
        {
            return ResponseEntity.status(HttpStatus.OK).body(isDeleted);
        }
        return ResponseEntity.status(HttpStatus.FAILED_DEPENDENCY).body(false);

    }
   /* @GetMapping("/declarations/{id}/dons")
    public ResponseEntity<List<DonResponse>> getDonByIdDeclaration(@PathVariable String id)
    {
        List<DonResponse> donByDeclarationId = this.declarationService.getDonByDeclarationId(id);
        return ResponseEntity.status(HttpStatus.OK).body(donByDeclarationId);
    }*/
}
