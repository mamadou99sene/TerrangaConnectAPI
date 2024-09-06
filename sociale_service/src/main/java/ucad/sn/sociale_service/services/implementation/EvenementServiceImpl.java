package ucad.sn.sociale_service.services.implementation;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.sociale_service.clients.DemandeurRestClient;
import ucad.sn.sociale_service.dto.EvenementRequest;
import ucad.sn.sociale_service.dto.EvenementResponse;
import ucad.sn.sociale_service.entities.Evenement;
import ucad.sn.sociale_service.mappers.EvenementMapper;
import ucad.sn.sociale_service.models.Demandeur;
import ucad.sn.sociale_service.repositories.EvenementRepository;
import ucad.sn.sociale_service.services.EvenementService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class EvenementServiceImpl implements EvenementService {
    private final EvenementRepository evenementRepository;
    private final EvenementMapper evenementMapper;
    private  final DemandeurRestClient demandeurRestClient;

    public EvenementServiceImpl(EvenementRepository evenementRepository, EvenementMapper evenementMapper, DemandeurRestClient demandeurRestClient) {
        this.evenementRepository = evenementRepository;
        this.evenementMapper = evenementMapper;
        this.demandeurRestClient = demandeurRestClient;
    }

    @Override
    public EvenementResponse getEvenementById(String id) {
        Optional<Evenement> optionalEvenement = this.evenementRepository.findById(id);
        if(optionalEvenement.isPresent())
        {
            Evenement evenement = optionalEvenement.get();
            Demandeur demandeur=this.demandeurRestClient.findUtilisateurById(evenement.getDemandeurId());
            evenement.setDemandeurs(demandeur);
            return this.evenementMapper.convertToDTO(evenement);
        }
        else
            throw new RuntimeException("Aucun evenement correspondant avec cet identifiant");
    }

    @Override
    public List<EvenementResponse> getAllEvenements() {
        List<EvenementResponse> responseList = this.evenementRepository.
                findAll().
                stream().
                map(this.evenementMapper::convertToDTO).
                collect(Collectors.toList());
        for (EvenementResponse response :responseList
        ) {
            Demandeur demandeur=this.demandeurRestClient.findUtilisateurById(response.getDemandeurId());
            response.setDemandeur(demandeur);
        }
        return responseList;
    }

    @Override
    public EvenementResponse saveEvenement(EvenementRequest request, List<MultipartFile> files) {
        Evenement evenement = this.evenementMapper.convertToEntitie(request, files);
        Demandeur demandeur=this.demandeurRestClient.findUtilisateurById(evenement.getDemandeurId());
        evenement.setDemandeurs(demandeur);
        return this.evenementMapper.convertToDTO(this.evenementRepository.save(evenement));
    }

    @Override
    public EvenementResponse updateEvenement(EvenementRequest request, String id) {
        return null;
    }

    @Override
    public Boolean deleteEvenement(String id) {
        return null;
    }
}
