package ucad.sn.gestiondonservice.mappers;

import org.springframework.stereotype.Component;
import ucad.sn.gestiondonservice.dto.DonSangRequest;
import ucad.sn.gestiondonservice.dto.DonSangResponse;
import ucad.sn.gestiondonservice.entities.DonSang;
import ucad.sn.gestiondonservice.enums.TypeDon;
import ucad.sn.gestiondonservice.services.ImageService;

import java.time.LocalDateTime;

@Component
public class DonSangMapper extends DonMapper{
    public DonSangMapper(ImageService imageService) {
        super(imageService);
    }

    public DonSang convertToEntitie(DonSangRequest request)
    {
        DonSang donSang=new DonSang();
        donSang.setDonateurId(request.getDonateurId());
        donSang.setDatePublication(LocalDateTime.now());
        donSang.setDeclarationId(request.getDeclarationId());
        donSang.setType(TypeDon.SANG);
        donSang.setAdresseDonnateur(request.getAdresseDonnateur());
        return donSang;
    }
    public DonSangResponse convertToDTO(DonSang donSang)
    {
        DonSangResponse response=new DonSangResponse();
        response.setId(donSang.getId());
        response.setAdresseDonnateur(donSang.getAdresseDonnateur());
        response.setType(TypeDon.valueOf(donSang.getType().name()));
        response.setDeclarationId(donSang.getDeclarationId());
        response.setDonnateur(donSang.getDonnateur());
        response.setDonateurId(donSang.getDonateurId());
        response.setDatePublication(donSang.getDatePublication());
        return response;
    }
}
