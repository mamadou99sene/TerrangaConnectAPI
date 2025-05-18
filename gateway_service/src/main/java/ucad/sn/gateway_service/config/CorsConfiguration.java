package ucad.sn.gateway_service.config;

import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.web.cors.reactive.CorsWebFilter;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.WebFilter;
import org.springframework.web.server.WebFilterChain;
import reactor.core.publisher.Mono;

import java.util.Arrays;

@Configuration
public class CorsConfiguration {

    @Bean
    public CorsWebFilter corsWebFilter() {
        org.springframework.web.cors.CorsConfiguration corsConfig = new org.springframework.web.cors.CorsConfiguration();
        corsConfig.setAllowedOrigins(Arrays.asList("*"));
        corsConfig.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        corsConfig.setAllowedHeaders(Arrays.asList("*"));
        corsConfig.setExposedHeaders(Arrays.asList("Authorization", "Content-Type"));
        corsConfig.setAllowCredentials(false);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", corsConfig);

        return new CorsWebFilter(source);
    }
    @Bean
    public GlobalFilter tokenRelayFilter() {
        return (exchange, chain) -> {
            // Récupérer les en-têtes de la requête entrante
            HttpHeaders headers = exchange.getRequest().getHeaders();

            // Vérifier si l'en-tête d'autorisation existe
            if (headers.containsKey("Authorization")) {
                // Copier l'en-tête d'autorisation dans la requête sortante
                return chain.filter(exchange.mutate()
                        .request(r -> r.headers(requestHeaders -> {
                            String authorizationHeader = headers.getFirst("Authorization");
                            requestHeaders.set("Authorization", authorizationHeader);
                        }))
                        .build());
            }

            return chain.filter(exchange);
        };
    }
}