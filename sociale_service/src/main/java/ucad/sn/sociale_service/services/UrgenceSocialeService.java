package ucad.sn.sociale_service.services;

import org.springframework.web.multipart.MultipartFile;
import ucad.sn.sociale_service.dto.UrgenceSocialeRequest;
import ucad.sn.sociale_service.dto.UrgenceSocialeResponse;

import java.util.List;

public interface UrgenceSocialeService {
    public List<UrgenceSocialeResponse> getAllUrgenceSociale();
    public UrgenceSocialeResponse getUrgenceSocialeById(String id);
    public UrgenceSocialeResponse saveUrgenceSociale(UrgenceSocialeRequest request, List<MultipartFile> files);
}
