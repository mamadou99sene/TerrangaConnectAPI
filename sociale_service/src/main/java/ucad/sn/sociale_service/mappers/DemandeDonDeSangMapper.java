package ucad.sn.sociale_service.mappers;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.sociale_service.dto.DemandeDonDeSangRequest;
import ucad.sn.sociale_service.dto.DemandeDonDeSangResponse;
import ucad.sn.sociale_service.entities.DemandeDondeSang;
import ucad.sn.sociale_service.enums.StatusDeclaration;
import ucad.sn.sociale_service.services.ImageService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class DemandeDonDeSangMapper extends DeclarationMapper{


    public DemandeDonDeSangMapper(ImageService imageService) {
        super(imageService);
    }

    public DemandeDondeSang convertToEntitie(DemandeDonDeSangRequest request, List<MultipartFile> files)
    {
        DemandeDondeSang demandeDonDeSang = new DemandeDondeSang();
        demandeDonDeSang.setTitre(request.getTitre());
        demandeDonDeSang.setDatePublication(LocalDateTime.now());
        demandeDonDeSang.setDemandeurId(request.getDemandeurId());
        demandeDonDeSang.setDescription(request.getDescription());
        demandeDonDeSang.setStatus(StatusDeclaration.PENDING);
        demandeDonDeSang.setAdresse(request.getAdresse());
        demandeDonDeSang.setClasse(request.getClasse());
        demandeDonDeSang.setRhesus(request.getRhesus());
        List<String> imagePaths = files.stream()
                .map(imageService::saveImage)
                .collect(Collectors.toList());
        demandeDonDeSang.setImages(imagePaths);
        return demandeDonDeSang;
    }
    public DemandeDonDeSangResponse convertToDTO(DemandeDondeSang demandeDondeSang)
    {
        DemandeDonDeSangResponse response = new DemandeDonDeSangResponse();
        response.setId(demandeDondeSang.getId());
        response.setTitre(demandeDondeSang.getTitre());
        response.setDescription(demandeDondeSang.getDescription());
        response.setStatus(demandeDondeSang.getStatus());
        response.setDatePublication(demandeDondeSang.getDatePublication());
        response.setDemandeurId(demandeDondeSang.getDemandeurId());
        response.setDemandeur(demandeDondeSang.getDemandeurs());
        List<String> imagesPath=demandeDondeSang.getImages().
                stream().
                map(imageService::getImageUrl).
                collect(Collectors.toList());
        response.setImages(imagesPath);
        response.setAdresse(demandeDondeSang.getAdresse());
        response.setClasse(demandeDondeSang.getClasse());
        response.setRhesus(demandeDondeSang.getRhesus());
        return response;
    }
}
