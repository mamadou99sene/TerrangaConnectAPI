package ucad.sn.sociale_service.services;

import org.springframework.web.multipart.MultipartFile;
import ucad.sn.sociale_service.dto.EvenementRequest;
import ucad.sn.sociale_service.dto.EvenementResponse;

import java.util.List;

public interface EvenementService {
    public EvenementResponse getEvenementById(String id);
    public List<EvenementResponse> getAllEvenements();
    public EvenementResponse saveEvenement(EvenementRequest request, List<MultipartFile> files);
    public EvenementResponse updateEvenement(EvenementRequest request, String id);
    public Boolean deleteEvenement(String id);
}
