package ucad.sn.gestiondonservice.services.implementation;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.gestiondonservice.dto.*;
import ucad.sn.gestiondonservice.services.*;

import java.util.List;

@Service
public class DonServiceImpl implements DonService {
    private DonEspeceService donEspeceService;
    private DonMaterielService donMaterielService;
    private DonSangService donSangService;
    private PretService pretService;

    public DonServiceImpl(DonEspeceService donEspeceService, DonMaterielService donMaterielService, DonSangService donSangService, PretService pretService) {
        this.donEspeceService = donEspeceService;
        this.donMaterielService = donMaterielService;
        this.donSangService = donSangService;
        this.pretService = pretService;
    }


    @Override
    public List<DonEspeceResponse> getAllDonsEspece() {
        return this.donEspeceService.getAllDonsEspece();
    }

    @Override
    public List<DonEspeceResponse> getAllDonsEspeceByDeclarationId(String decalarationId) {
        return this.donEspeceService.getAllDonsEspeceByDeclarationId(decalarationId);
    }

    @Override
    public DonEspeceResponse getDonEspecebyId(String idDonEspece) {
        return this.donEspeceService.getDonEspecebyId(idDonEspece);
    }

    @Override
    public DonEspeceResponse saveDonEspece(DonEspeceRequest request) {
        return this.donEspeceService.saveDonEspece(request);
    }

    @Override
    public List<DonMaterielResponse> getAllDonsMateriel() {
        return this.donMaterielService.getAllDonsMateriel();
    }

    @Override
    public List<DonMaterielResponse> getAllDonsMaterielByDeclarationId(String decalarationId) {
        return this.donMaterielService.getAllDonsMaterielByDeclarationId(decalarationId);
    }

    @Override
    public DonMaterielResponse getDonMaterielbyId(String idDonMateriel) {
        return this.donMaterielService.getDonMaterielbyId(idDonMateriel);
    }

    @Override
    public DonMaterielResponse saveDonMateriel(DonMaterielRequest request, List<MultipartFile> files) {
        return this.donMaterielService.saveDonMateriel(request, files);
    }

    @Override
    public List<DonSangResponse> getAllDonsSang() {
        return this.donSangService.getAllDonsSang();
    }

    @Override
    public List<DonSangResponse> getAllDonsSangByDeclarationId(String declarationId) {
        return this.donSangService.getAllDonsSangByDeclarationId(declarationId);
    }

    @Override
    public DonSangResponse getDonSangbyId(String idDonSang) {
        return this.donSangService.getDonSangbyId(idDonSang);
    }

    @Override
    public DonSangResponse saveDonSang(DonSangRequest request) {
        return this.donSangService.saveDonSang(request);
    }


    @Override
    public List<PretResponse> getAllDonsPret() {
        return this.pretService.getAllDonsPret();
    }

    @Override
    public List<PretResponse> getAllDonsPretByDeclarationId(String declarationId) {
        return this.pretService.getAllDonsPretByDeclarationId(declarationId);
    }

    @Override
    public PretResponse getDonPretbyId(String idPret) {
        return this.pretService.getDonPretbyId(idPret);
    }

    @Override
    public PretResponse saveDonPret(PretRequest request, List<MultipartFile> files) {
        return this.pretService.saveDonPret(request, files);
    }
}
