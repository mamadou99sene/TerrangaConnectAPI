package ucad.sn.utilisateur_service.services.implementation;
import org.springframework.core.io.Resource;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.utilisateur_service.dto.UtilisateurRequest;
import ucad.sn.utilisateur_service.entities.Utilisateur;
import ucad.sn.utilisateur_service.mappers.Mapper;
import ucad.sn.utilisateur_service.repositories.UtilisateurRepository;
import ucad.sn.utilisateur_service.services.ProfilService;
import ucad.sn.utilisateur_service.services.UtilisateurService;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class UtilisateurServiceImpl implements UtilisateurService {
    private UtilisateurRepository utilisateurRepository;
    private final PasswordEncoder passwordEncoder;
    private final Mapper mapper;
    private ProfilService profilService;

    public UtilisateurServiceImpl(UtilisateurRepository utilisateurRepository, PasswordEncoder passwordEncoder, Mapper mapper, ProfilService profilService) {
        this.utilisateurRepository = utilisateurRepository;
        this.passwordEncoder = passwordEncoder;
        this.mapper = mapper;
        this.profilService = profilService;
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

    @Override
    public Utilisateur uploadProfil(String idUtiliateur, MultipartFile profil) {
        Optional<Utilisateur> optionalUtilisateur = this.utilisateurRepository.findById(idUtiliateur);
        if(optionalUtilisateur.isPresent())
        {
            Utilisateur utilisateur=optionalUtilisateur.get();
            if(utilisateur.getProfile()!=null)
                this.profilService.deleteImage(utilisateur.getProfile());
            String imageProfil=this.profilService.saveImage(profil);
            utilisateur.setProfile(imageProfil);
            this.utilisateurRepository.save(utilisateur);
            return utilisateur;
        }
        else
            throw new RuntimeException("L'utilisateur est introuvable");
    }

    @Override
    public Resource getProfileUtilisateur(String idUtilisateur) {
        Utilisateur utilisateur=getUtilisateurById(idUtilisateur);
        if(utilisateur==null || utilisateur.getProfile()==null)
        {
            throw new RuntimeException("Utilisateur ou image non trouvé");
        }
        Resource profil=this.profilService.loadImage(utilisateur.getProfile());
        return profil;
    }
}
