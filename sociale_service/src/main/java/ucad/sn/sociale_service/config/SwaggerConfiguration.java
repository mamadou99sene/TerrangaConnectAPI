package ucad.sn.sociale_service.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;

import java.util.Collections;

@Configuration
public class SwaggerConfiguration {
    String schemeName = "bearerAuth";
    String bearerFormat = "JWT";
    String scheme = "bearer";

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .servers(Collections.singletonList(new Server()
                        .url("http://localhost:8081")
                        .description("Developpement")))
                .info(new Info()
                        .title("Teranga Connect REST API")
                        .description("Gestion urgence sociale documentation")
                        .version("v1.0")
                        .contact(new Contact()
                                .name("Mamadou SENE")
                                .email("senemamadou1999@@gmail.com")
                                .url("https://github.com/mamadou99sene")
                        )
                )
                .addSecurityItem(new SecurityRequirement()
                        .addList(schemeName))
                .components(new Components().addSecuritySchemes(
                                schemeName, new SecurityScheme()
                                .name(schemeName)
                                .type(SecurityScheme.Type.HTTP)
                                .bearerFormat(bearerFormat)
                                .in(SecurityScheme.In.HEADER)
                                .scheme(scheme)
                ))
                ;
    }

    @Bean
    public WebSecurityCustomizer webSecurityCustomizer () {
        return web -> web.ignoring().requestMatchers(
                "/swagger-ui/**" , "/v3/api-docs/**"
        );
    }
}
