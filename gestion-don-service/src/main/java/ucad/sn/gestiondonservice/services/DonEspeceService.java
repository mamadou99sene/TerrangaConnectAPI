package ucad.sn.gestiondonservice.services;

import ucad.sn.gestiondonservice.dto.DonEspeceRequest;
import ucad.sn.gestiondonservice.dto.DonEspeceResponse;

import java.util.List;

public interface DonEspeceService {
    public List<DonEspeceResponse> getAllDonsEspece();
    public List<DonEspeceResponse> getAllDonsEspeceByDeclarationId(String declarationId);
    public DonEspeceResponse getDonEspecebyId(String idDonEspece);
    public DonEspeceResponse saveDonEspece(DonEspeceRequest request);

}
