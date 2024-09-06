package ucad.sn.gestiondonservice.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ucad.sn.gestiondonservice.dto.*;
import ucad.sn.gestiondonservice.services.DonService;

import java.util.List;

@RestController
@RequestMapping("/api")
public class DonController {
    private DonService donService;

    public DonController(DonService donService) {
        this.donService = donService;
    }
@GetMapping("/donsEspece")
    public ResponseEntity<List<DonEspeceResponse>> getAllDonsEspece()
    {
        List<DonEspeceResponse> allDonsEspece = this.donService.getAllDonsEspece();
        return ResponseEntity.status(HttpStatus.OK).body(allDonsEspece);
    }
    @GetMapping("/declarations/{declarationId}/donsEspece")
    public ResponseEntity<List<DonEspeceResponse>> getAllDonsEspeceByDeclarationId(@PathVariable String declarationId)
    {
        List<DonEspeceResponse> allDonsEspeceByDeclarationId = this.donService.getAllDonsEspeceByDeclarationId(declarationId);
        return ResponseEntity.status(HttpStatus.OK).body(allDonsEspeceByDeclarationId);
    }
    @GetMapping("/donsEspece/{idDonEspece}")
    public ResponseEntity<DonEspeceResponse> getDonEspecebyId(@PathVariable String idDonEspece){
        DonEspeceResponse donEspeceResponse = this.donService.getDonEspecebyId(idDonEspece);
        if(donEspeceResponse==null)
        {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.status(HttpStatus.OK).body(donEspeceResponse);
    }
    @PostMapping("/donsEspece")
    public ResponseEntity<DonEspeceResponse> saveDonEspece(@RequestBody DonEspeceRequest request)
    {
        DonEspeceResponse response = this.donService.saveDonEspece(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
    @GetMapping("/donsMateriel")
    public ResponseEntity<List<DonMaterielResponse>> getAllDonsMateriel()
    {
        List<DonMaterielResponse> allDonsMateriel = this.donService.getAllDonsMateriel();
        return ResponseEntity.status(HttpStatus.OK).body(allDonsMateriel);
    }
    @GetMapping("/declarations/{declarationId}/donsMateriel")
    public ResponseEntity<List<DonMaterielResponse>> getAllDonsMaterielByDeclarationId(@PathVariable String declarationId)
    {
        List<DonMaterielResponse> responseList = this.donService.getAllDonsMaterielByDeclarationId(declarationId);
        return ResponseEntity.status(HttpStatus.OK).body(responseList);
    }
    @GetMapping("/donsMateriel/{idDonMateriel}")
    public ResponseEntity<DonMaterielResponse> getDonMaterielbyId(@PathVariable String idDonMateriel)
    {
        DonMaterielResponse donMaterielbyId = this.donService.getDonMaterielbyId(idDonMateriel);
        if(donMaterielbyId==null)
        {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.status(HttpStatus.OK).body(donMaterielbyId);

    }
    @PostMapping("/donsMateriel")
    public ResponseEntity<DonMaterielResponse> saveDonMateriel(@ModelAttribute DonMaterielRequest request,
                                                               @RequestParam("images") List<MultipartFile> files)
    {
        DonMaterielResponse saveDonMateriel = this.donService.saveDonMateriel(request, files);
        return ResponseEntity.status(HttpStatus.CREATED).body(saveDonMateriel);
    }
    @GetMapping("/donsSang")
    public ResponseEntity<List<DonSangResponse>> getAllDonsSang()
    {
        List<DonSangResponse> allDonsSang = this.donService.getAllDonsSang();
        return ResponseEntity.status(HttpStatus.OK).body(allDonsSang);
    }
    @GetMapping("/declarations/{declarationId}/donsSang")
    public ResponseEntity<List<DonSangResponse>> getAllDonsSangByDeclarationId(@PathVariable String declarationId)
    {
        List<DonSangResponse> allDonsSangByDeclarationId = this.donService.getAllDonsSangByDeclarationId(declarationId);
        return ResponseEntity.status(HttpStatus.OK).body(allDonsSangByDeclarationId);
    }
    @GetMapping("/donsSang/{idDonSang}")
    public ResponseEntity<DonSangResponse> getDonSangbyId(@PathVariable String idDonSang)
    {
        DonSangResponse donSangResponse = this.donService.getDonSangbyId(idDonSang);
        if(donSangResponse==null)
        {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.status(HttpStatus.OK).body(donSangResponse);
    }
@PostMapping("/donsSang")
    public ResponseEntity<DonSangResponse> saveDonSang(@RequestBody DonSangRequest request)
    {
        DonSangResponse donSangResponse = this.donService.saveDonSang(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(donSangResponse);
    }
@GetMapping("/prets")
    public ResponseEntity<List<PretResponse>> getAllPret()
    {
        List<PretResponse> donsPret = this.donService.getAllDonsPret();
        return ResponseEntity.status(HttpStatus.OK).body(donsPret);
    }
    @GetMapping("/declarations/{declarationId}/prets")
    public ResponseEntity<List<PretResponse>> getAllPretByDeclarationId(@PathVariable String declarationId)
    {
        List<PretResponse> pretByDeclarationId = this.donService.getAllDonsPretByDeclarationId(declarationId);
        return ResponseEntity.status(HttpStatus.OK).body(pretByDeclarationId);
    }
    @GetMapping("/prets/{idPret}")
    public ResponseEntity<PretResponse>  getPretbyId(@PathVariable String idPret)
    {
        PretResponse pretbyId = this.donService.getDonPretbyId(idPret);
        if (pretbyId==null)
        {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.status(HttpStatus.OK).body(pretbyId);
    }
    @PostMapping("/prets")
    public ResponseEntity<PretResponse> savePret(@ModelAttribute PretRequest request,
                                                 @RequestParam("images") List<MultipartFile> files)
    {
        PretResponse saveDonPret = this.donService.saveDonPret(request, files);
        return ResponseEntity.status(HttpStatus.CREATED).body(saveDonPret);
    }
}
