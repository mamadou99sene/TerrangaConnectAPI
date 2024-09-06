package ucad.sn.gestiondonservice.services.implementation;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.gestiondonservice.clients.DonnateurRestClient;
import ucad.sn.gestiondonservice.dto.PretRequest;
import ucad.sn.gestiondonservice.dto.PretResponse;
import ucad.sn.gestiondonservice.entities.Pret;
import ucad.sn.gestiondonservice.mappers.PretMapper;
import ucad.sn.gestiondonservice.models.Donnateur;
import ucad.sn.gestiondonservice.repositories.PretRepository;
import ucad.sn.gestiondonservice.services.PretService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class PretServiceImpl implements PretService {
    private PretRepository pretRepository;
    private PretMapper pretMapper;
    private DonnateurRestClient donnateurRestClient;

    public PretServiceImpl(PretRepository pretRepository, PretMapper pretMapper, DonnateurRestClient donnateurRestClient) {
        this.pretRepository = pretRepository;
        this.pretMapper = pretMapper;
        this.donnateurRestClient = donnateurRestClient;
    }

    @Override
    public List<PretResponse> getAllDonsPret() {
        List<PretResponse> responseList = this.pretRepository.
                findAll().
                stream().
                map(this.pretMapper::convertToDTO).
                collect(Collectors.toList());
        for (PretResponse response :responseList
        ) {
            Donnateur donnateur=donnateurRestClient.getDonnateurById(response.getDonateurId());
            response.setDonnateur(donnateur);
        }
        return responseList;
    }

    @Override
    public List<PretResponse> getAllDonsPretByDeclarationId(String declarationId) {
       return this.pretRepository.
                findPretsByDeclarationId(declarationId).
                stream().map(pret -> {
                    Donnateur donnateur=donnateurRestClient.getDonnateurById(pret.getDonateurId());
                    pret.setDonnateur(donnateur);
                   return this.pretMapper.convertToDTO(pret);
               }).
                collect(Collectors.toList());
    }

    @Override
    public PretResponse getDonPretbyId(String idPret) {

        Optional<Pret> optionalPret = this.pretRepository.findById(idPret);
        if (optionalPret.isPresent())
        {
            Pret pret=optionalPret.get();
            Donnateur donnateur=donnateurRestClient.getDonnateurById(pret.getDonateurId());
            pret.setDonnateur(donnateur);
            return this.pretMapper.convertToDTO(pret);

        }
        else
            throw new RuntimeException("Le pret associé avec cette reference n'existe pas");
    }

    @Override
    public PretResponse saveDonPret(PretRequest request, List<MultipartFile> files) {

        Pret pret = this.pretMapper.convertToEntitie(request, files);
        Donnateur donnateur=this.donnateurRestClient.getDonnateurById(pret.getDonateurId());
        pret.setDonnateur(donnateur);
        return this.pretMapper.convertToDTO(this.pretRepository.save(pret));
    }
}
