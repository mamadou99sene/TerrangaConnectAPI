package ucad.sn.sociale_service.services;

import org.springframework.web.multipart.MultipartFile;
import ucad.sn.sociale_service.dto.DemandeDonDeSangRequest;
import ucad.sn.sociale_service.dto.DemandeDonDeSangResponse;
import java.util.List;

public interface DemandeDondeSangService {
    public DemandeDonDeSangResponse getDemandeDondeSangById(String id);
    public List<DemandeDonDeSangResponse> getAllDemandesDondeSang();
    public DemandeDonDeSangResponse saveDemandeDondeSang(DemandeDonDeSangRequest request, List<MultipartFile> files);
    public DemandeDonDeSangResponse updateEvenement(DemandeDonDeSangRequest request, String id);
    public Boolean deleteDemandeDon(String id);
}
