package ucad.sn.sociale_service.mappers;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.sociale_service.dto.EvenementRequest;
import ucad.sn.sociale_service.dto.EvenementResponse;
import ucad.sn.sociale_service.entities.Evenement;
import ucad.sn.sociale_service.enums.StatusDeclaration;
import ucad.sn.sociale_service.services.ImageService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class EvenementMapper extends  DeclarationMapper{

    public EvenementMapper(ImageService imageService) {
        super(imageService);
    }

    public Evenement convertToEntitie(EvenementRequest request, List<MultipartFile> files)
    {
        Evenement evenement=new Evenement();
        evenement.setTitre(request.getTitre());
        evenement.setType(request.getType());
        evenement.setDemandeurId(request.getDemandeurId());
        evenement.setDescription(request.getDescription());
        evenement.setLieu(request.getLieu());
        evenement.setDateDebut(request.getDateDebut());
        evenement.setDateFin(request.getDateFin());
        evenement.setDatePublication(LocalDateTime.now());
        evenement.setStatus(StatusDeclaration.PENDING);
        List<String> imagePath=files.stream()
                .map(this.imageService::saveImage).
                collect(Collectors.toList());
        evenement.setImages(imagePath);
        return evenement;

    }
    public EvenementResponse convertToDTO(Evenement evenement)
    {
        EvenementResponse response=new EvenementResponse();
        response.setId(evenement.getId());
        response.setTitre(evenement.getTitre());
        response.setDescription(evenement.getDescription());
        response.setStatus(evenement.getStatus());
        response.setDatePublication(evenement.getDatePublication());
        response.setDemandeurId(evenement.getDemandeurId());
        response.setDemandeur(evenement.getDemandeurs());
        List<String> images = evenement.getImages().
                stream().
                map(image->"http://localhost:8081/ucad/sn/sociale_service/MesImages/"+image).
                collect(Collectors.toList());
        response.setImages(images);
        response.setLieu(evenement.getLieu());
        response.setType(evenement.getType());
        response.setDateDebut(evenement.getDateDebut());
        response.setDateFin(evenement.getDateFin());
        return response;
    }
}
