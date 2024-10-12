package ucad.sn.gestiondonservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.openfeign.EnableFeignClients;
import ucad.sn.gestiondonservice.config.GlobalConfig;

@SpringBootApplication
@EnableFeignClients
@EnableConfigurationProperties(GlobalConfig.class)
public class GestionDonServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(GestionDonServiceApplication.class, args);
    }

}
