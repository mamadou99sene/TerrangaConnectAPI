package ucad.sn.utilisateur_service.services;

import ucad.sn.utilisateur_service.dto.UtilisateurRequest;
import ucad.sn.utilisateur_service.entities.Utilisateur;

import java.util.List;

public interface UtilisateurService {
    public List<Utilisateur> getAllUtilisateurs();
    public Utilisateur getUtilisateurById(String id);
    public Utilisateur updateutilisateur(UtilisateurRequest utilisateur, String id);
    public boolean deleteUtilisateur(String id);
    public Utilisateur createUtilisateur(UtilisateurRequest utilisateur);
    public List<Utilisateur> createListOfUser(List<UtilisateurRequest> utilisateurRequestList);
}
