package ucad.sn.utilisateur_service.services;

import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;
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
    public Utilisateur uploadProfil(String idUtiliateur, MultipartFile profil);
    public Resource getProfileUtilisateur(String idUtilisateur);
}
