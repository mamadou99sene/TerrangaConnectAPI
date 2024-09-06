package ucad.sn.utilisateur_service.services.implementation;

import org.springframework.stereotype.Service;
import ucad.sn.utilisateur_service.entities.Demandeur;
import ucad.sn.utilisateur_service.repositories.DemandeurRepository;
import ucad.sn.utilisateur_service.services.DemandeurService;

import java.util.List;
import java.util.Optional;

@Service
public class DemandeurServiceImpl implements DemandeurService {
    private DemandeurRepository demandeurRepository;

    public DemandeurServiceImpl(DemandeurRepository demandeurRepository) {
        this.demandeurRepository = demandeurRepository;
    }

    @Override
    public Demandeur getdemandeurById(String id) {
        Optional<Demandeur> optionalDemandeur = this.demandeurRepository.findById(id);
        if (optionalDemandeur.isPresent())
        {
            Demandeur demandeur=optionalDemandeur.get();
            return demandeur;
        }
        else
            throw new RuntimeException("Le demandeur n'existe pas");
    }

    @Override
    public List<Demandeur> getAllDemandeurs() {
        List<Demandeur> demandeurs = this.demandeurRepository.findAll();
        return demandeurs;
    }

    @Override
    public Demandeur saveDemandeur(Demandeur demandeur) {
        Demandeur saved = this.demandeurRepository.save(demandeur);
        return saved;

    }
}
