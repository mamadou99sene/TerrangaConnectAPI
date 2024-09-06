package ucad.sn.gestiondonservice.services;


import ucad.sn.gestiondonservice.dto.DonSangRequest;
import ucad.sn.gestiondonservice.dto.DonSangResponse;

import java.util.List;

public interface DonSangService {
    public List<DonSangResponse> getAllDonsSang();
    public List<DonSangResponse> getAllDonsSangByDeclarationId(String decalarationId);
    public DonSangResponse getDonSangbyId(String idDonSang);
    public DonSangResponse saveDonSang(DonSangRequest request);

}
