package ucad.sn.sociale_service.entities;

import jakarta.persistence.Entity;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;
import ucad.sn.sociale_service.enums.ClasseSang;
import ucad.sn.sociale_service.enums.Rhesus;
@Entity @NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class DemandeDondeSang extends Declaration{
     String adresse;
     ClasseSang classe;
     Rhesus rhesus;

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
