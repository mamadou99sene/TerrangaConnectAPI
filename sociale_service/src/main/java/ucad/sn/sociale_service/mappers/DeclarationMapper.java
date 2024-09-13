package ucad.sn.sociale_service.mappers;

import org.springframework.stereotype.Component;
import ucad.sn.sociale_service.dto.*;
import ucad.sn.sociale_service.entities.Declaration;
import ucad.sn.sociale_service.services.ImageService;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class DeclarationMapper {
    protected ImageService imageService;

    public DeclarationMapper(ImageService imageService) {
        this.imageService = imageService;
    }

    public DeclarationResponse convertToDTO(Declaration declaration)
    {
       DeclarationResponse response=new DeclarationResponse();
       response.setTitre(declaration.getTitre());
       response.setId(declaration.getId());
       response.setDescription(declaration.getDescription());
       response.setStatus(declaration.getStatus());
       response.setDatePublication(declaration.getDatePublication());
       response.setDemandeurId(declaration.getDemandeurId());
       response.setDemandeur(declaration.getDemandeurs());
        List<String> images=declaration.getImages().
                stream().
                map(image->"http://localhost:8888/SOCIALE-SERVICE/mesImages/"+image).
                collect(Collectors.toList());
       response.setImages(images);
      return response;
    }
}
