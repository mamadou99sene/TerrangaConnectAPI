package ucad.sn.sociale_service.entities;

import jakarta.persistence.Entity;
import lombok.Builder;
import lombok.NoArgsConstructor;
import ucad.sn.sociale_service.enums.ClasseSang;
import ucad.sn.sociale_service.enums.Rhesus;
@Entity @NoArgsConstructor
public class DemandeDondeSang extends Declaration{
    private String adresse;
    private ClasseSang classe;
    private Rhesus rhesus;

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public ClasseSang getClasse() {
        return classe;
    }

    public void setClasse(ClasseSang classe) {
        this.classe = classe;
    }

    public Rhesus getRhesus() {
        return rhesus;
    }

    public void setRhesus(Rhesus rhesus) {
        this.rhesus = rhesus;
    }
}
