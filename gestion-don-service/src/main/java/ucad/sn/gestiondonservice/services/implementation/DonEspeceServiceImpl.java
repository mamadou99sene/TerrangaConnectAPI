package ucad.sn.gestiondonservice.services.implementation;

import org.springframework.stereotype.Service;
import ucad.sn.gestiondonservice.clients.DonnateurRestClient;
import ucad.sn.gestiondonservice.dto.DonEspeceRequest;
import ucad.sn.gestiondonservice.dto.DonEspeceResponse;
import ucad.sn.gestiondonservice.entities.DonEspece;
import ucad.sn.gestiondonservice.mappers.DonEspeceMapper;
import ucad.sn.gestiondonservice.models.Donnateur;
import ucad.sn.gestiondonservice.repositories.DonEspeceRepository;
import ucad.sn.gestiondonservice.services.DonEspeceService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
@Service
public class DonEspeceServiceImpl implements DonEspeceService {
    private DonEspeceRepository donEspeceRepository;
    private DonEspeceMapper donEspeceMapper;
    private DonnateurRestClient donnateurRestClient;

    public DonEspeceServiceImpl(DonEspeceRepository donEspeceRepository, DonEspeceMapper donEspeceMapper, DonnateurRestClient donnateurRestClient) {
        this.donEspeceRepository = donEspeceRepository;
        this.donEspeceMapper = donEspeceMapper;
        this.donnateurRestClient = donnateurRestClient;
    }

    @Override
    public List<DonEspeceResponse> getAllDonsEspece() {
        List<DonEspeceResponse> responseList = this.donEspeceRepository.
                findAll()
                .stream().
                map(this.donEspeceMapper::convertToDTO).
                collect(Collectors.toList());
        for (DonEspeceResponse response:responseList
             ) {
            Donnateur donnateur=donnateurRestClient.getDonnateurById(response.getDonateurId());
            response.setDonnateur(donnateur);
        }
        return responseList;
    }

    @Override
    public List<DonEspeceResponse> getAllDonsEspeceByDeclarationId(String decalarationId) {
        List<DonEspeceResponse> responseList = this.donEspeceRepository.
                findDonEspecesByDeclarationId(decalarationId).
                stream().
                map(donEspece -> {
                    Donnateur donnateur=donnateurRestClient.getDonnateurById(donEspece.getDonateurId());
                    donEspece.setDonnateur(donnateur);
                   return this.donEspeceMapper.convertToDTO(donEspece);
                }).collect(Collectors.toList());
        return responseList;
    }

    @Override
    public DonEspeceResponse getDonEspecebyId(String idDonEspece) {
        Optional<DonEspece> optDonEspece = this.donEspeceRepository.findById(idDonEspece);
        if (optDonEspece.isPresent())
        {
            DonEspece donEspece=optDonEspece.get();
            Donnateur donnateur=this.donnateurRestClient.getDonnateurById(donEspece.getDonateurId());
            donEspece.setDonnateur(donnateur);
            return this.donEspeceMapper.convertToDTO(donEspece);
        }
        else
            throw new RuntimeException("Le don espece demandé est introuvable");

    }

    @Override
    public DonEspeceResponse saveDonEspece(DonEspeceRequest request) {
        DonEspece donEspece=this.donEspeceMapper.convertToEntitie(request);
        Donnateur donnateur=this.donnateurRestClient.getDonnateurById(request.getDonateurId());
        donEspece.setDonnateur(donnateur);
        return this.donEspeceMapper.convertToDTO(this.donEspeceRepository.save(donEspece));
    }
}
