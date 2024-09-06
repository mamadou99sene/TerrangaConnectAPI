package ucad.sn.gestiondonservice.services.implementation;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.gestiondonservice.clients.DonnateurRestClient;
import ucad.sn.gestiondonservice.dto.DonMaterielRequest;
import ucad.sn.gestiondonservice.dto.DonMaterielResponse;
import ucad.sn.gestiondonservice.entities.DonMateriel;
import ucad.sn.gestiondonservice.mappers.DonMaterielMapper;
import ucad.sn.gestiondonservice.models.Donnateur;
import ucad.sn.gestiondonservice.repositories.DonMaterielRepository;
import ucad.sn.gestiondonservice.services.DonMaterielService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class DonMaterielServiceImpl implements DonMaterielService {
    private DonMaterielRepository donMaterielRepository;
    private DonMaterielMapper donMaterielMapper;
    private DonnateurRestClient donnateurRestClient;

    public DonMaterielServiceImpl(DonMaterielRepository donMaterielRepository, DonMaterielMapper donMaterielMapper, DonnateurRestClient donnateurRestClient) {
        this.donMaterielRepository = donMaterielRepository;
        this.donMaterielMapper = donMaterielMapper;
        this.donnateurRestClient = donnateurRestClient;
    }

    @Override
    public List<DonMaterielResponse> getAllDonsMateriel() {
        List<DonMaterielResponse> responseList = this.donMaterielRepository.
                findAll().
                stream().
                map(this.donMaterielMapper::convertToDTO).
                collect(Collectors.toList());
        for (DonMaterielResponse response:responseList
             ) {
            Donnateur donnateur=donnateurRestClient.getDonnateurById(response.getDonateurId());
            response.setDonnateur(donnateur);
        }
        return responseList;
    }

    @Override
    public List<DonMaterielResponse> getAllDonsMaterielByDeclarationId(String declarationId) {
        return this.donMaterielRepository.
                findDonMaterielsByDeclarationId(declarationId)
                .stream().
                map(donMateriel -> {
                    Donnateur donnateur=this.donnateurRestClient.getDonnateurById(donMateriel.getDonateurId());
                    donMateriel.setDonnateur(donnateur);
                    return this.donMaterielMapper.convertToDTO(donMateriel);
                }).
                collect(Collectors.toList());
    }

    @Override
    public DonMaterielResponse getDonMaterielbyId(String idDonMateriel) {

        Optional<DonMateriel> optionalDonMateriel = this.donMaterielRepository.findById(idDonMateriel);
        if (optionalDonMateriel.isPresent())
        {
            DonMateriel donMateriel=optionalDonMateriel.get();
            Donnateur donnateur=this.donnateurRestClient.getDonnateurById(donMateriel.getDonateurId());
            donMateriel.setDonnateur(donnateur);
            return this.donMaterielMapper.convertToDTO(donMateriel);
        }
        else
            throw new RuntimeException("Le don Matériel est introuvable");
    }

    @Override
    public DonMaterielResponse saveDonMateriel(DonMaterielRequest request, List<MultipartFile> files) {

        DonMateriel donMateriel = this.donMaterielMapper.convertToEntitie(request, files);
        Donnateur donnateur=this.donnateurRestClient.getDonnateurById(request.getDonateurId());
        donMateriel.setDonnateur(donnateur);
       return this.donMaterielMapper.convertToDTO(this.donMaterielRepository.save(donMateriel));
    }
}
