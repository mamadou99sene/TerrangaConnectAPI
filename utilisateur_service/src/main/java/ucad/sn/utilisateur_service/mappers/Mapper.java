package ucad.sn.utilisateur_service.mappers;
import org.springframework.stereotype.Component;
import ucad.sn.utilisateur_service.dto.UtilisateurRequest;
import ucad.sn.utilisateur_service.entities.Utilisateur;
@Component
public class Mapper {
   public static Utilisateur mapToEntitie(UtilisateurRequest request)
   {
       Utilisateur utilisateur=new Utilisateur();
       utilisateur.setEmail(request.getEmail());
       utilisateur.setTelephone(request.getTelephone());
       utilisateur.setScore(request.getScore());
       utilisateur.setPassword(request.getPassword());
       utilisateur.setRoles(request.getRoles());
       return utilisateur;
   }
}
