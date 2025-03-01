package ucad.sn.assistanceservice.controllers;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;
import ucad.sn.assistanceservice.services.AssistanceService;

@RestController
@RequestMapping("/api")
public class AssistanceController {
    private ChatClient chatClient;
    private AssistanceService assistanceService;

    public AssistanceController(ChatClient.Builder builder, AssistanceService assistanceService) {
        this.chatClient=builder.build();
        this.assistanceService = assistanceService;
    }


    @GetMapping("/chat")
    public ResponseEntity<String> chat(String query)
    {
        String content= chatClient.prompt().
                user(query).
                call().
                content();
        return ResponseEntity.status(HttpStatus.OK).body(content);
    }
    @GetMapping("/chatOpenAI")
    public ResponseEntity<String> queryRagOpenAi(String query)
    {
        String content=this.assistanceService.ragQueryOpenAi(query);
        return ResponseEntity.status(HttpStatus.OK).body(content);
    }
   /* @GetMapping("/chatOllama")
    public ResponseEntity<String> queryRagOllama(String query)
    {
        String content=this.assistanceService.ragQueryOllama(query);
        return ResponseEntity.status(HttpStatus.OK).body(content);
    }*/
    @GetMapping(value = "/assistance", produces = MediaType.TEXT_PLAIN_VALUE+ ";charset=UTF-8")
    public ResponseEntity<Flux<String>> queryWithAllModels(String query)
    {
        Flux<String> content=this.assistanceService.ragQueryWithAllModel(query);
        return ResponseEntity.status(HttpStatus.OK).body(content);
    }
}
