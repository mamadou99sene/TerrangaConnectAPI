package ucad.sn.gestiondonservice.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Getter @Setter @NoArgsConstructor
public class DonMateriel extends Don{
    private String titre;
    private String description;
    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "DonMateriel_images", joinColumns = @JoinColumn(name = "Don_id"))
    @Column(name = "image_path")
    private List<String> imagesDon;
}
