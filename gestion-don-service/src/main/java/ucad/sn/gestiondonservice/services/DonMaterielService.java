package ucad.sn.gestiondonservice.services;

import org.springframework.web.multipart.MultipartFile;
import ucad.sn.gestiondonservice.dto.DonMaterielRequest;
import ucad.sn.gestiondonservice.dto.DonMaterielResponse;

import java.util.List;

public interface DonMaterielService {
    public List<DonMaterielResponse> getAllDonsMateriel();
    public List<DonMaterielResponse> getAllDonsMaterielByDeclarationId(String declarationId);
    public DonMaterielResponse getDonMaterielbyId(String idDonMateriel);
    public DonMaterielResponse saveDonMateriel(DonMaterielRequest request, List<MultipartFile> files);

}
