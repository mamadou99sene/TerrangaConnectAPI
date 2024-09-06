package ucad.sn.gestiondonservice.services;

import org.springframework.web.multipart.MultipartFile;
import ucad.sn.gestiondonservice.dto.PretRequest;
import ucad.sn.gestiondonservice.dto.PretResponse;

import java.util.List;

public interface PretService {
    public List<PretResponse> getAllDonsPret();
    public List<PretResponse> getAllDonsPretByDeclarationId(String decalarationId);
    public PretResponse getDonPretbyId(String idPret);
    public PretResponse saveDonPret(PretRequest request, List<MultipartFile> files);

}
