package ucad.sn.sociale_service.entities;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import ucad.sn.sociale_service.enums.StatusDeclaration;
import ucad.sn.sociale_service.models.Demandeur;
import ucad.sn.sociale_service.models.Don;

import java.time.LocalDateTime;
import java.util.List;

@Entity @Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
@Inheritance(strategy = InheritanceType.JOINED)
@FieldDefaults(level = AccessLevel.PROTECTED)
public class Declaration {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
     String id;
     String titre;
     String description;
     LocalDateTime datePublication;
     StatusDeclaration status;
     String demandeurId;
    @Transient
     Demandeur demandeurs;
    //@OneToMany(fetch = FetchType.LAZY, cascade=ALL, mappedBy="declaration")
    @Transient
     List<Don> don;
    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "declaration_images", joinColumns = @JoinColumn(name = "declaration_id"))
    @Column(name = "image_path")
     List<String> images;

}
