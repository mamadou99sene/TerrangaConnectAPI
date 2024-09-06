package ucad.sn.sociale_service.services.implementation;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.sociale_service.clients.DemandeurRestClient;
import ucad.sn.sociale_service.dto.UrgenceSocialeRequest;
import ucad.sn.sociale_service.dto.UrgenceSocialeResponse;
import ucad.sn.sociale_service.entities.UrgenceSociale;
import ucad.sn.sociale_service.mappers.UrgenceSocialeMapper;
import ucad.sn.sociale_service.models.Demandeur;
import ucad.sn.sociale_service.repositories.UrgenceSocialeRepository;
import ucad.sn.sociale_service.services.UrgenceSocialeService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UrgenceSocialeServiceImpl implements UrgenceSocialeService {
    private final UrgenceSocialeRepository urgenceSocialeRepository;
    private final UrgenceSocialeMapper mapper;
    private final DemandeurRestClient demandeurRestClient;


    public UrgenceSocialeServiceImpl(UrgenceSocialeRepository urgenceSocialeRepository, UrgenceSocialeMapper mapper, DemandeurRestClient demandeurRestClient) {
        this.urgenceSocialeRepository = urgenceSocialeRepository;
        this.mapper = mapper;
        this.demandeurRestClient = demandeurRestClient;
    }

    @Override
    public List<UrgenceSocialeResponse> getAllUrgenceSociale() {
        return this.urgenceSocialeRepository.
                findAll().
                stream().
                map(urgenceSociale -> {
                    Demandeur demandeur=this.demandeurRestClient.findUtilisateurById(urgenceSociale.getDemandeurId());
                    urgenceSociale.setDemandeurs(demandeur);
                    return this.mapper.mapToDto(urgenceSociale);
                }).
                collect(Collectors.toList());
    }

    @Override
    public UrgenceSocialeResponse getUrgenceSocialeById(String id) {

        Optional<UrgenceSociale> optUrgence = this.urgenceSocialeRepository.findById(id);
        if(optUrgence.isPresent())
        {
            UrgenceSociale urgenceSociale = optUrgence.get();
            Demandeur demandeur=this.demandeurRestClient.findUtilisateurById(urgenceSociale.getDemandeurId());
            urgenceSociale.setDemandeurs(demandeur);
            return this.mapper.mapToDto(urgenceSociale);
        }
        else
            throw new RuntimeException("Aucune urgence retrouvée sous cet identifiant");
    }

    @Override
    public UrgenceSocialeResponse saveUrgenceSociale(UrgenceSocialeRequest request, List<MultipartFile> files) {
        UrgenceSociale urgenceSociale = this.mapper.convertToEntitie(request, files);
        Demandeur demandeur=this.demandeurRestClient.findUtilisateurById(urgenceSociale.getDemandeurId());
        urgenceSociale.setDemandeurs(demandeur);
        return this.mapper.mapToDto(this.urgenceSocialeRepository.save(urgenceSociale));
    }
}
