package ucad.sn.utilisateur_service.services.implementation;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ucad.sn.utilisateur_service.dto.UtilisateurRequest;
import ucad.sn.utilisateur_service.entities.Utilisateur;
import ucad.sn.utilisateur_service.mappers.Mapper;
import ucad.sn.utilisateur_service.repositories.UtilisateurRepository;
import ucad.sn.utilisateur_service.services.UtilisateurService;

import java.util.ArrayList;
import java.util.List;
@Service
public class UtilisateurServiceImpl implements UtilisateurService {
    private UtilisateurRepository utilisateurRepository;
    private final PasswordEncoder passwordEncoder;
    private final Mapper mapper;

    public UtilisateurServiceImpl(UtilisateurRepository utilisateurRepository, PasswordEncoder passwordEncoder, Mapper mapper) {
        this.utilisateurRepository = utilisateurRepository;
        this.passwordEncoder = passwordEncoder;
        this.mapper = mapper;
    }

    @Override
    public List<Utilisateur> getAllUtilisateurs() {
        return this.utilisateurRepository.findAll();
    }

    @Override
    public Utilisateur getUtilisateurById(String id) {
        return this.utilisateurRepository.findById(id).get();
    }

    @Override
    public Utilisateur updateutilisateur(UtilisateurRequest request, String id) {
        Utilisateur loaded=this.utilisateurRepository.findById(id).get();
        if (loaded!=null)
        {

            loaded= mapper.mapToEntitie(request);
            this.utilisateurRepository.save(loaded);
            return loaded;
        }
        throw new  RuntimeException("cet utilisateur n'existe pas !!!");
    }

    @Override
    public boolean deleteUtilisateur(String id) {
        Utilisateur utilisateur=this.utilisateurRepository.findById(id).get();
        if(utilisateur!=null)
        {
            this.utilisateurRepository.delete(utilisateur);
            return true;
        }
        return false;
    }

    @Override
    public Utilisateur createUtilisateur(UtilisateurRequest utilisateurRequest) {
        utilisateurRequest.setPassword(passwordEncoder.encode(utilisateurRequest.getPassword()));
       return this.utilisateurRepository.save(mapper.mapToEntitie(utilisateurRequest));
    }

    @Override
    public List<Utilisateur> createListOfUser(List<UtilisateurRequest> utilisateurRequestList) {
        List<Utilisateur> utilisateurList=new ArrayList<Utilisateur>();
        for (UtilisateurRequest request:utilisateurRequestList
             ) {
            request.setPassword(passwordEncoder.encode(request.getPassword()));
            utilisateurList.add(mapper.mapToEntitie(request));

        }
        return utilisateurRepository.saveAll(utilisateurList);
    }
}
