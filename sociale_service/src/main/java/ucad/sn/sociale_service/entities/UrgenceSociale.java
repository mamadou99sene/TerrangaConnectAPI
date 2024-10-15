package ucad.sn.sociale_service.entities;

import jakarta.persistence.Entity;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.antlr.v4.runtime.misc.NotNull;
import ucad.sn.sociale_service.enums.TypeUrgence;

@Entity @NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UrgenceSociale extends Declaration{
     String lieu;
     TypeUrgence type;
    @NotNull
     double montantRequis;
    public String getLieu() {
        return lieu;
    }

    public void setLieu(String lieu) {
        this.lieu = lieu;
    }

    public TypeUrgence getType() {
        return type;
    }

    public void setType(TypeUrgence type) {
        this.type = type;
    }

    public double getMontantRequis() {
        return montantRequis;
    }

    public void setMontantRequis(double montantRequis) {
        this.montantRequis = montantRequis;
    }

    public UrgenceSociale(String lieu, TypeUrgence type, Double montantRequis) {
        this.lieu = lieu;
        this.type = type;
        this.montantRequis=montantRequis;
    }

}
