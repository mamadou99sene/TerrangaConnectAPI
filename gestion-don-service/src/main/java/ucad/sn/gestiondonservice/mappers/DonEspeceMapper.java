package ucad.sn.gestiondonservice.mappers;

import org.springframework.stereotype.Component;
import ucad.sn.gestiondonservice.dto.DonEspeceRequest;
import ucad.sn.gestiondonservice.dto.DonEspeceResponse;
import ucad.sn.gestiondonservice.entities.DonEspece;
import ucad.sn.gestiondonservice.enums.TypeDon;
import ucad.sn.gestiondonservice.services.ImageService;

import java.time.LocalDateTime;

@Component
public class DonEspeceMapper extends DonMapper{


    public DonEspeceMapper(ImageService imageService) {
        super(imageService);
    }

    public DonEspece convertToEntitie(DonEspeceRequest request)
    {
        DonEspece donEspece=new DonEspece();
        donEspece.setMontant(request.getMontant());
        donEspece.setType(TypeDon.ESPECE);
        donEspece.setDatePublication(LocalDateTime.now());
        donEspece.setDeclarationId(request.getDeclarationId());
        donEspece.setDonateurId(request.getDonateurId());
      return donEspece;
    }
    public DonEspeceResponse convertToDTO(DonEspece donEspece)
    {
        DonEspeceResponse response=new DonEspeceResponse();
        response.setId(donEspece.getId());
        response.setMontant(donEspece.getMontant());
        response.setType(TypeDon.valueOf(donEspece.getType().name()));
        response.setDatePublication(donEspece.getDatePublication());
        response.setDeclarationId(donEspece.getDeclarationId());
        response.setDonnateur(donEspece.getDonnateur());
        response.setDonateurId(donEspece.getDonateurId());
        return response;
    }
}
