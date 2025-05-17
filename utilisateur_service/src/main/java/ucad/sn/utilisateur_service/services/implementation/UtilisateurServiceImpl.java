package ucad.sn.utilisateur_service.services.implementation;
import jakarta.ws.rs.core.Response;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.resource.RealmResource;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.admin.client.resource.UsersResource;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.utilisateur_service.dto.UtilisateurRequest;
import ucad.sn.utilisateur_service.entities.Utilisateur;
import ucad.sn.utilisateur_service.mappers.Mapper;
import ucad.sn.utilisateur_service.repositories.UtilisateurRepository;
import ucad.sn.utilisateur_service.services.ProfilService;
import ucad.sn.utilisateur_service.services.UtilisateurService;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UtilisateurServiceImpl implements UtilisateurService {
    private UtilisateurRepository utilisateurRepository;
    private final Mapper mapper;
    private ProfilService profilService;

    public UtilisateurServiceImpl(UtilisateurRepository utilisateurRepository, Mapper mapper, ProfilService profilService) {
        this.utilisateurRepository = utilisateurRepository;
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
        Utilisateur utilisateur = mapper.mapToEntitie(utilisateurRequest);
        String keycloakId = createUserInKeycloak(utilisateurRequest);
        utilisateur.setKeycloakId(keycloakId);

        return utilisateurRepository.save(utilisateur);
    }

    private String createUserInKeycloak(UtilisateurRequest request) {
        // Création d'une instance Keycloak avec les identifiants admin
        Keycloak keycloak = Keycloak.getInstance(
                "http://localhost:8080",
                "master",
                "admin",
                "admin",
                "admin-cli");
        // Accès aux ressources du realm
        RealmResource realmResource = keycloak.realm("teranga_realm");
        UsersResource usersResource = realmResource.users();

        // Création de la représentation de l'utilisateur
        UserRepresentation user = new UserRepresentation();
        user.setEnabled(true);
        user.setUsername(request.getEmail());
        user.setEmail(request.getEmail());

        user.setEmailVerified(true);
        Response response = usersResource.create(user);

        if (response.getStatus() != 201) {
            throw new RuntimeException("Échec lors de la création de l'utilisateur dans Keycloak. Code: " + response.getStatus());
        }

        // Extraction de l'ID utilisateur depuis la réponse
        String locationHeader = response.getHeaderString("Location");
        if (locationHeader == null) {
            throw new RuntimeException("Location header not found in Keycloak response");
        }
        String[] parts = locationHeader.split("/");
        String userId = parts[parts.length - 1];

        // Configuration du mot de passe non temporaire
        UserResource userResource = usersResource.get(userId);
        CredentialRepresentation credential = new CredentialRepresentation();
        credential.setType(CredentialRepresentation.PASSWORD);
        credential.setValue(request.getPassword());
        credential.setTemporary(false);
        userResource.resetPassword(credential);

        // Attribution des rôles à l'utilisateur
        if (request.getRoles() != null && !request.getRoles().isEmpty()) {
            // Conversion des rôles enum en string
            List<String> roleNames = request.getRoles().stream()
                    .map(Enum::name)
                    .collect(Collectors.toList());

            // Attribution des rôles un par un
            for (String roleName : roleNames) {
                RoleRepresentation role = realmResource.roles().get(roleName).toRepresentation();
                userResource.roles().realmLevel().add(Collections.singletonList(role));
            }
        }

        return userId;
    }
    @Override
    public List<Utilisateur> createListOfUser(List<UtilisateurRequest> utilisateurRequestList) {
        List<Utilisateur> utilisateurList=new ArrayList<Utilisateur>();
        for (UtilisateurRequest request:utilisateurRequestList
             ) {
           // request.setPassword(passwordEncoder.encode(request.getPassword()));
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

    @Override
    public Utilisateur getUtilisateurByKeycloak_id(String keycloak_id) {
        return this.utilisateurRepository.
                findByKeycloakId(keycloak_id).
                orElseThrow(()->new RuntimeException("L'utilisateur n'existe pas"));
    }
}
