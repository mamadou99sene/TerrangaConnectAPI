package ucad.sn.sociale_service.entities;

import jakarta.persistence.Entity;
import lombok.NoArgsConstructor;
import ucad.sn.sociale_service.enums.TypeEvenement;

import java.time.LocalDateTime;
@Entity @NoArgsConstructor
public class Evenement extends Declaration{
    private String lieu;
    private TypeEvenement type;
    private LocalDateTime dateDebut;
    private LocalDateTime dateFin;

    public String getLieu() {
        return lieu;
    }

    public void setLieu(String lieu) {
        this.lieu = lieu;
    }

    public TypeEvenement getType() {
        return type;
    }

    public void setType(TypeEvenement type) {
        this.type = type;
    }

    public LocalDateTime getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(LocalDateTime dateDebut) {
        this.dateDebut = dateDebut;
    }

    public LocalDateTime getDateFin() {
        return dateFin;
    }

    public void setDateFin(LocalDateTime dateFin) {
        this.dateFin = dateFin;
    }
}
