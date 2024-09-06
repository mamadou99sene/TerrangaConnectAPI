package ucad.sn.gestiondonservice.services;

import org.springframework.web.multipart.MultipartFile;
import ucad.sn.gestiondonservice.dto.*;

import java.util.List;

public interface DonService {
    public List<DonEspeceResponse> getAllDonsEspece();
    public List<DonEspeceResponse> getAllDonsEspeceByDeclarationId(String declarationId);
    public DonEspeceResponse getDonEspecebyId(String idDonEspece);
    public DonEspeceResponse saveDonEspece(DonEspeceRequest request);
    public List<DonMaterielResponse> getAllDonsMateriel();
    public List<DonMaterielResponse> getAllDonsMaterielByDeclarationId(String declarationId);
    public DonMaterielResponse getDonMaterielbyId(String idDonMateriel);
    public DonMaterielResponse saveDonMateriel(DonMaterielRequest request, List<MultipartFile> files);
    public List<DonSangResponse> getAllDonsSang();
    public List<DonSangResponse> getAllDonsSangByDeclarationId(String declarationId);
    public DonSangResponse getDonSangbyId(String idDonSang);

    DonSangResponse saveDonSang(DonSangRequest request);

    public List<PretResponse> getAllDonsPret();
    public List<PretResponse> getAllDonsPretByDeclarationId(String declarationId);
    public PretResponse getDonPretbyId(String idPret);
    public PretResponse saveDonPret(PretRequest request, List<MultipartFile> files);
}
