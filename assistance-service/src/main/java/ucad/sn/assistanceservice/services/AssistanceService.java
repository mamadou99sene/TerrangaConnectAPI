package ucad.sn.assistanceservice.services;

import org.springframework.core.io.Resource;
import reactor.core.publisher.Flux;

public interface AssistanceService {
    public String ragQueryOpenAi(String query);
 //   public String ragQueryOllama(String query);
    public Flux<String> ragQueryWithAllModel(String query);
    public void splitChunksEmbedAnsStore(Resource[] pfdResources);
}
