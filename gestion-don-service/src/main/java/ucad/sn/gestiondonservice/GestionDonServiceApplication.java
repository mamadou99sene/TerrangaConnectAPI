package ucad.sn.gestiondonservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients
public class GestionDonServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(GestionDonServiceApplication.class, args);
    }

}
