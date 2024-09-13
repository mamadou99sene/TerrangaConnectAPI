package ucad.sn.sociale_service.mappers;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.sociale_service.dto.UrgenceSocialeRequest;
import ucad.sn.sociale_service.dto.UrgenceSocialeResponse;
import ucad.sn.sociale_service.entities.UrgenceSociale;
import ucad.sn.sociale_service.enums.StatusDeclaration;
import ucad.sn.sociale_service.services.ImageService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class UrgenceSocialeMapper extends DeclarationMapper{


    public UrgenceSocialeMapper(ImageService imageService) {
        super(imageService);
    }

    public UrgenceSociale convertToEntitie(UrgenceSocialeRequest request, List<MultipartFile> files)
    {
        UrgenceSociale urgenceSociale = new UrgenceSociale();
        urgenceSociale.setTitre(request.getTitre());
        urgenceSociale.setDatePublication(LocalDateTime.now());
        urgenceSociale.setDemandeurId(request.getDemandeurId());
        urgenceSociale.setDescription(request.getDescription());
        urgenceSociale.setStatus(StatusDeclaration.PENDING);
        urgenceSociale.setLieu(request.getLieu());
        urgenceSociale.setType(request.getType());
        urgenceSociale.setMontantRequis(request.getMontantRequis());
        List<String> imagesPath=files.stream().
                map(this.imageService::saveImage).
                collect(Collectors.toList());
        urgenceSociale.setImages(imagesPath);
        return urgenceSociale;
    }

    public UrgenceSocialeResponse mapToDto(UrgenceSociale urgenceSociale)
    {
        UrgenceSocialeResponse response = new UrgenceSocialeResponse();
        response.setId(urgenceSociale.getId());
        response.setTitre(urgenceSociale.getTitre());
        response.setDescription(urgenceSociale.getDescription());
        response.setStatus(urgenceSociale.getStatus());
        response.setDatePublication(urgenceSociale.getDatePublication());
        response.setDemandeurId(urgenceSociale.getDemandeurId());
        response.setDemandeur(urgenceSociale.getDemandeurs());
        List<String> imagesPath=urgenceSociale.getImages().stream().map(image->
            "http://localhost:8888/SOCIALE-SERVICE/mesImages/"+image
        ).collect(Collectors.toList());
        response.setImages(imagesPath);
        response.setLieu(urgenceSociale.getLieu());
        response.setType(urgenceSociale.getType());
        response.setMontantRequis(urgenceSociale.getMontantRequis());
        return response;
    }
}
