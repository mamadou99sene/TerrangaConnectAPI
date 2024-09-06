package ucad.sn.sociale_service.mappers;

import org.springframework.stereotype.Component;
import ucad.sn.sociale_service.dto.*;
import ucad.sn.sociale_service.entities.Declaration;
import ucad.sn.sociale_service.services.ImageService;

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
       response.setImages(declaration.getImages());
      return response;
    }
}
