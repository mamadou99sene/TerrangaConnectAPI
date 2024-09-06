package ucad.sn.utilisateur_service.services;

import ucad.sn.utilisateur_service.entities.Demandeur;

import java.util.List;

public interface DemandeurService {
    public Demandeur getdemandeurById(String id);
    public List<Demandeur> getAllDemandeurs();
    public Demandeur saveDemandeur(Demandeur demandeur);
}
