package ucad.sn.sociale_service.services.implementation;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.sociale_service.dto.*;
import ucad.sn.sociale_service.entities.Declaration;
import ucad.sn.sociale_service.mappers.DeclarationMapper;
import ucad.sn.sociale_service.repositories.DeclarationRepository;
import ucad.sn.sociale_service.services.*;

import java.util.List;
import java.util.Optional;

@Service
public class DeclarationServiceImpl implements DeclarationService {
    private final UrgenceSocialeService urgenceSocialeService;
    private final DemandeDondeSangService demandeDondeSangService;
    private final EvenementService evenementService;
    private final DeclarationRepository declarationRepository;
    private final DeclarationMapper declarationMapper;
    private final ImageService imageService;

    public DeclarationServiceImpl(UrgenceSocialeService urgenceSocialeService, DemandeDondeSangService demandeDondeSangService, EvenementService evenementService, DeclarationRepository declarationRepository, DeclarationMapper declarationMapper, ImageService imageService) {
        this.urgenceSocialeService = urgenceSocialeService;
        this.demandeDondeSangService = demandeDondeSangService;
        this.evenementService = evenementService;
        this.declarationRepository = declarationRepository;
        this.declarationMapper = declarationMapper;
        this.imageService = imageService;
    }

    @Override
    public List<UrgenceSocialeResponse> getAllUrgenceDeclaration() {
        return this.urgenceSocialeService.getAllUrgenceSociale();
    }

    @Override
    public List<DemandeDonDeSangResponse> getAllDemandeDonDeclaration() {
        return this.demandeDondeSangService.getAllDemandesDondeSang();
    }

    @Override
    public List<EvenementResponse> getAllEventDeclaration() {
        return this.evenementService.getAllEvenements();
    }

    @Override
    public UrgenceSocialeResponse getUrgenceDeclarationById(String id) {
        return this.urgenceSocialeService.getUrgenceSocialeById(id);
    }

    @Override
    public DemandeDonDeSangResponse getDemandeDeclarationById(String id) {
        return this.demandeDondeSangService.getDemandeDondeSangById(id);

    }

    @Override
    public EvenementResponse getEventDeclarationById(String id) {
        return this.evenementService.getEvenementById(id);
    }

    @Override
    public UrgenceSocialeResponse saveUrgenceDeclaration(UrgenceSocialeRequest request, List<MultipartFile> files) {
        return this.urgenceSocialeService.saveUrgenceSociale(request,files);
    }

    @Override
    public DemandeDonDeSangResponse saveDemandeDonDeclaration(DemandeDonDeSangRequest request, List<MultipartFile> files) {
        return this.demandeDondeSangService.saveDemandeDondeSang(request, files);
    }

    @Override
    public EvenementResponse saveEventDeclaration(EvenementRequest request, List<MultipartFile> files) {
        return this.evenementService.saveEvenement(request, files);
    }
    @Override
    public Boolean deleteDeclaration(String id) {
        Optional<Declaration> declarationByid=this.declarationRepository.findById(id);
        if (declarationByid.isPresent())
        {
            List<String> images=declarationByid.get().getImages();
            for (String image:images
                 ) {
                this.imageService.deleteImage(image);
            }
            this.declarationRepository.delete(declarationByid.get());
            return true;
        }
        return false;
    }

    @Override
    public DeclarationResponse updateDeclaration(DeclarationRequest request, String id) {
        Optional<Declaration> optdeclaration=this.declarationRepository.findById(id);
        if(optdeclaration.isPresent())
        {
            Declaration declaration = optdeclaration.get();
            declaration.setTitre(request.getTitre());
            declaration.setDescription(request.getDescription());
            return this.declarationMapper.convertToDTO(this.declarationRepository.save(declaration));
        }
        else {
            throw new RuntimeException("La declaration n'est pas present");
        }
    }

/*    @Override
    public List<DonResponse> getDonByDeclarationId(String idDeclaation) {
        Optional<Declaration> optbyId = this.declarationRepository.findById(idDeclaation);
        if (optbyId.isPresent())
        {
            Declaration declaration=optbyId.get();
            List<Don> lisOfDon=declaration.getDon();
            return lisOfDon.stream().map(this.donMapper::convertToDTO).collect(Collectors.toList());

        }
        else
            throw new RuntimeException("La declaration n'est pas trouvée");
    }*/
}
