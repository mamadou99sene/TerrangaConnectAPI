package ucad.sn.gestiondonservice.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity @Getter @Setter @NoArgsConstructor
public class Pret extends Don{
    private String titre;
    private String description;
    private int duree;
    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "Pret_images", joinColumns = @JoinColumn(name = "Pret_id"))
    @Column(name = "image_path")
    private List<String> imagesPret;
}
