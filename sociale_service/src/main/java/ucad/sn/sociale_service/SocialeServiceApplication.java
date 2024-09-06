package ucad.sn.sociale_service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients
public class SocialeServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(SocialeServiceApplication.class, args);
    }

}
