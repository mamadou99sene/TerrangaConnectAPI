package ucad.sn.gestiondonservice.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import ucad.sn.gestiondonservice.enums.TypeDon;
import ucad.sn.gestiondonservice.models.Donnateur;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter @Setter
@Inheritance(strategy = InheritanceType.JOINED)
public class Don {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    protected String id;
    protected LocalDateTime datePublication;

    protected TypeDon type;
/*    @ManyToOne
    @JoinColumn(name="declaration_id", nullable=false)*/
    protected String declarationId;
    protected String donateurId;
    @Transient
    protected Donnateur donnateur;
}
