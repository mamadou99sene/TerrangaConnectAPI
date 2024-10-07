package ucad.sn.gestiondonservice.mappers;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.gestiondonservice.dto.PretRequest;
import ucad.sn.gestiondonservice.dto.PretResponse;
import ucad.sn.gestiondonservice.entities.Pret;
import ucad.sn.gestiondonservice.enums.TypeDon;
import ucad.sn.gestiondonservice.services.ImageService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class PretMapper extends DonMapper{
    public PretMapper(ImageService imageService) {
        super(imageService);
    }

    public Pret convertToEntitie(PretRequest request, List<MultipartFile> files)
    {
        Pret pret=new Pret();
        pret.setTitre(request.getTitre());
        pret.setDescription(request.getDescription());
        pret.setDatePublication(LocalDateTime.now());
        pret.setType(TypeDon.PRET);
        pret.setDeclarationId(request.getDeclarationId());
        pret.setDonateurId(request.getDonateurId());
        pret.setDuree(request.getDuree());
        List<String> imagesPret=files.stream().
                map(this.imageService::saveImage).
                collect(Collectors.toList());
        pret.setImagesPret(imagesPret);
       return pret;
    }
    public PretResponse convertToDTO(Pret pret)
    {
        PretResponse response=new PretResponse();
        response.setId(pret.getId());
        response.setTitre(pret.getTitre());
        response.setDescription(pret.getDescription());
        response.setType(pret.getType());
        response.setDatePublication(pret.getDatePublication());
        response.setDonnateur(pret.getDonnateur());
        response.setDonateurId(pret.getDonateurId());
        response.setDeclarationId(pret.getDeclarationId());
        response.setDuree(pret.getDuree());
        List<String> imagesUrl=pret.
                getImagesPret().
                stream().
                map(this.imageService::getImageUrl).
                collect(Collectors.toList());
        response.setImages(imagesUrl);
        return response;
    }
}
