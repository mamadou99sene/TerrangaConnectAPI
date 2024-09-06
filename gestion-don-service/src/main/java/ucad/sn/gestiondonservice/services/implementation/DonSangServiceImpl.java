package ucad.sn.gestiondonservice.services.implementation;

import org.springframework.stereotype.Service;
import ucad.sn.gestiondonservice.clients.DonnateurRestClient;
import ucad.sn.gestiondonservice.dto.DonSangRequest;
import ucad.sn.gestiondonservice.dto.DonSangResponse;
import ucad.sn.gestiondonservice.entities.DonSang;
import ucad.sn.gestiondonservice.mappers.DonSangMapper;
import ucad.sn.gestiondonservice.models.Donnateur;
import ucad.sn.gestiondonservice.repositories.DonSangRepository;
import ucad.sn.gestiondonservice.services.DonSangService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class DonSangServiceImpl implements DonSangService {
    private DonSangRepository donSangRepository;
    private DonSangMapper donSangMapper;
    private DonnateurRestClient donnateurRestClient;

    public DonSangServiceImpl(DonSangRepository donSangRepository, DonSangMapper donSangMapper, DonnateurRestClient donnateurRestClient) {
        this.donSangRepository = donSangRepository;
        this.donSangMapper = donSangMapper;
        this.donnateurRestClient = donnateurRestClient;
    }

    @Override
    public List<DonSangResponse> getAllDonsSang() {
        List<DonSangResponse> responseList = this.donSangRepository.
                findAll().
                stream().
                map(this.donSangMapper::convertToDTO).
                collect(Collectors.toList());
        for (DonSangResponse response :responseList
        ) {
            Donnateur donnateur=this.donnateurRestClient.getDonnateurById(response.getDonateurId());
            response.setDonnateur(donnateur);
        }
        return responseList;
    }

    @Override
    public List<DonSangResponse> getAllDonsSangByDeclarationId(String declarationId) {

        return this.donSangRepository.
                findDonSangsByDeclarationId(declarationId).
                stream().
                map(donSang -> {
                    Donnateur donnateur=this.donnateurRestClient.getDonnateurById(donSang.getDonateurId());
                    donSang.setDonnateur(donnateur);
                    return this.donSangMapper.convertToDTO(donSang);
                }).
                collect(Collectors.toList());
    }

    @Override
    public DonSangResponse getDonSangbyId(String idDonSang) {
        Optional<DonSang> optionalDonSang = this.donSangRepository.findById(idDonSang);
        if(optionalDonSang.isPresent())
        {
            DonSang donSang=optionalDonSang.get();
            Donnateur donnateur=this.donnateurRestClient.getDonnateurById(donSang.getDonateurId());
            donSang.setDonnateur(donnateur);
            return this.donSangMapper.convertToDTO(donSang);
        }
        else
            throw new RuntimeException("Le don de sang avec cet identifiant est introuvable");
    }

    @Override
    public DonSangResponse saveDonSang(DonSangRequest request) {
        DonSang donSang = this.donSangMapper.convertToEntitie(request);
        Donnateur donnateur=this.donnateurRestClient.getDonnateurById(donSang.getDonateurId());
        donSang.setDonnateur(donnateur);
       return this.donSangMapper.convertToDTO(this.donSangRepository.save(donSang));
    }
}
