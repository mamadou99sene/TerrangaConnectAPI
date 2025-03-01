package ucad.sn.gestiondonservice.config;

import lombok.*;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "spring.datasource")
@NoArgsConstructor @AllArgsConstructor @Getter @Setter @Builder
public class GlobalConfig {
    String username;
    String password;
}
