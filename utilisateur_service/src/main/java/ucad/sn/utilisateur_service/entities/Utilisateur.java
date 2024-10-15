package ucad.sn.utilisateur_service.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import ucad.sn.utilisateur_service.enums.Role;

import java.util.ArrayList;
import java.util.List;

@Entity
@Builder @AllArgsConstructor @NoArgsConstructor
@Inheritance(strategy = InheritanceType.JOINED)
@FieldDefaults(level = AccessLevel.PROTECTED)
public class Utilisateur {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
     String id;
     String email;
     String telephone;
     double score;
    @ElementCollection(fetch = FetchType.EAGER)
    @Enumerated(EnumType.STRING)
     List<Role> roles=new ArrayList<>();
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
     String password;
    @Transient
     static Utilisateur utilisateur;
     String profile;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    public static Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public static void setUtilisateur(Utilisateur utilisateur) {
        Utilisateur.utilisateur = utilisateur;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profileImagePath) {
        this.profile = profileImagePath;
    }

    public static Utilisateur getInstanceUtilisateur()
    {
        if (utilisateur==null)
        {
            utilisateur=new Utilisateur();
            return utilisateur;
        }
        return utilisateur;
    }
}
