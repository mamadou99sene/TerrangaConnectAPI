package ucad.sn.gestiondonservice.mappers;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.gestiondonservice.dto.DonMaterielRequest;
import ucad.sn.gestiondonservice.dto.DonMaterielResponse;
import ucad.sn.gestiondonservice.entities.DonMateriel;
import ucad.sn.gestiondonservice.enums.TypeDon;
import ucad.sn.gestiondonservice.services.ImageService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class DonMaterielMapper extends DonMapper{


    public DonMaterielMapper(ImageService imageService) {
        super(imageService);
    }

    public DonMateriel convertToEntitie(DonMaterielRequest request, List<MultipartFile> files)
    {
        DonMateriel donMateriel=new DonMateriel();
        donMateriel.setTitre(request.getTitre());
        donMateriel.setDatePublication(LocalDateTime.now());
        donMateriel.setDonateurId(request.getDonateurId());
        donMateriel.setDeclarationId(request.getDeclarationId());
        donMateriel.setDescription(request.getDescription());
        donMateriel.setType(TypeDon.MATERIEL);
        List<String> imagesDon=files.
                stream().
                map(this.imageService::saveImage).
                collect(Collectors.toList());
        donMateriel.setImagesDon(imagesDon);
        return donMateriel;
    }
    public DonMaterielResponse convertToDTO(DonMateriel donMateriel)
    {
        DonMaterielResponse response=new DonMaterielResponse();
        response.setId(donMateriel.getId());
        response.setTitre(donMateriel.getTitre());
        response.setDescription(donMateriel.getDescription());
        response.setDatePublication(donMateriel.getDatePublication());
        response.setType(donMateriel.getType());
        response.setDonnateur(donMateriel.getDonnateur());
        response.setDonateurId(donMateriel.getDonateurId());
        response.setDeclarationId(donMateriel.getDeclarationId());
        List<String> imagesUrl=donMateriel.
                getImagesDon().
                stream().
                map(this.imageService::getImageUrl).
                collect(Collectors.toList());
        donMateriel.setImagesDon(imagesUrl);
        return response;
    }
}
