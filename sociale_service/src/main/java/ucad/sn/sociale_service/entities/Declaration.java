package ucad.sn.sociale_service.entities;

import jakarta.persistence.*;
import lombok.*;
import ucad.sn.sociale_service.enums.StatusDeclaration;
import ucad.sn.sociale_service.models.Demandeur;
import ucad.sn.sociale_service.models.Don;

import java.time.LocalDateTime;
import java.util.List;

import static jakarta.persistence.CascadeType.ALL;

@Entity @Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
@Inheritance(strategy = InheritanceType.JOINED)
public class Declaration {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    protected String id;
    protected String titre;
    protected String description;
    protected LocalDateTime datePublication;
    protected StatusDeclaration status;
    protected String demandeurId;
    @Transient
    protected Demandeur demandeurs;
    //@OneToMany(fetch = FetchType.LAZY, cascade=ALL, mappedBy="declaration")
    @Transient
    protected List<Don> don;
    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "declaration_images", joinColumns = @JoinColumn(name = "declaration_id"))
    @Column(name = "image_path")
    protected List<String> images;

}
