package ucad.sn.sociale_service.services.implementation;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.sociale_service.clients.DemandeurRestClient;
import ucad.sn.sociale_service.dto.DemandeDonDeSangRequest;
import ucad.sn.sociale_service.dto.DemandeDonDeSangResponse;
import ucad.sn.sociale_service.entities.DemandeDondeSang;
import ucad.sn.sociale_service.mappers.DemandeDonDeSangMapper;
import ucad.sn.sociale_service.models.Demandeur;
import ucad.sn.sociale_service.repositories.DemandeDondeSangRepository;
import ucad.sn.sociale_service.services.DemandeDondeSangService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
@Service
public class DemandeDondeSangServiceImpl implements DemandeDondeSangService {
    private final DemandeDondeSangRepository demandeDondeSangRepository;
    private final DemandeDonDeSangMapper demandeDonDeSangMapper;
    private final DemandeurRestClient demandeurRestClient;

    public DemandeDondeSangServiceImpl(DemandeDondeSangRepository demandeDondeSangRepository, DemandeDonDeSangMapper demandeDonDeSangMapper, DemandeurRestClient demandeurRestClient) {
        this.demandeDondeSangRepository = demandeDondeSangRepository;
        this.demandeDonDeSangMapper = demandeDonDeSangMapper;
        this.demandeurRestClient = demandeurRestClient;
    }

    @Override
    public DemandeDonDeSangResponse getDemandeDondeSangById(String id) {
        Optional<DemandeDondeSang> optionalDemandeDondeSang = this.demandeDondeSangRepository.findById(id);
        if (optionalDemandeDondeSang.isPresent())
        {
            DemandeDondeSang demandeDondeSang = optionalDemandeDondeSang.get();
            Demandeur demandeur=this.demandeurRestClient.findUtilisateurById(demandeDondeSang.getDemandeurId());
            demandeDondeSang.setDemandeurs(demandeur);
            return this.demandeDonDeSangMapper.convertToDTO(demandeDondeSang);
        }
        else
            throw new RuntimeException("La demande de don de sang est introuvable");
    }

    @Override
    public List<DemandeDonDeSangResponse> getAllDemandesDondeSang() {

        List<DemandeDonDeSangResponse> responses = this.demandeDondeSangRepository.findAll().
                stream().
                map(this.demandeDonDeSangMapper::convertToDTO).
                collect(Collectors.toList());
        for (DemandeDonDeSangResponse response :responses
        ) {
            Demandeur demandeur=this.demandeurRestClient.findUtilisateurById(response.getDemandeurId());
            response.setDemandeur(demandeur);
        }
        return responses;

    }

    @Override
    public DemandeDonDeSangResponse saveDemandeDondeSang(DemandeDonDeSangRequest request, List<MultipartFile> files) {
        DemandeDondeSang demandeDondeSang = this.demandeDonDeSangMapper.convertToEntitie(request, files);
        Demandeur demandeur=this.demandeurRestClient.findUtilisateurById(demandeDondeSang.getDemandeurId());
        demandeDondeSang.setDemandeurs(demandeur);
        return this.demandeDonDeSangMapper.convertToDTO(this.demandeDondeSangRepository.save(demandeDondeSang));

    }

    @Override
    public DemandeDonDeSangResponse updateEvenement(DemandeDonDeSangRequest request, String id) {
        return null;
    }

    @Override
    public Boolean deleteDemandeDon(String id) {
        return null;
    }
}
