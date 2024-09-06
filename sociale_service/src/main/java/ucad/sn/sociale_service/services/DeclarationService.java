package ucad.sn.sociale_service.services;

import org.springframework.web.multipart.MultipartFile;
import ucad.sn.sociale_service.dto.*;

import java.util.List;

public interface DeclarationService {
    public List<UrgenceSocialeResponse> getAllUrgenceDeclaration();
    public List<DemandeDonDeSangResponse> getAllDemandeDonDeclaration();
    public List<EvenementResponse> getAllEventDeclaration();
    public  UrgenceSocialeResponse getUrgenceDeclarationById(String id);
    public  DemandeDonDeSangResponse getDemandeDeclarationById(String id);
    public  EvenementResponse getEventDeclarationById(String id);
    public UrgenceSocialeResponse saveUrgenceDeclaration(UrgenceSocialeRequest request, List<MultipartFile> files);
    public DemandeDonDeSangResponse saveDemandeDonDeclaration(DemandeDonDeSangRequest request, List<MultipartFile> files);
    public EvenementResponse saveEventDeclaration(EvenementRequest request, List<MultipartFile> files);
  public Boolean deleteDeclaration(String id);
    public DeclarationResponse updateDeclaration(DeclarationRequest request, String id);
    /*public List<DonResponse> getDonByDeclarationId(String idDeclaation);*/
}
