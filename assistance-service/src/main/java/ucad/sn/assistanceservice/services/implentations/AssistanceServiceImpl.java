package ucad.sn.assistanceservice.services.implentations;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.messages.Message;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.chat.prompt.SystemPromptTemplate;
import org.springframework.ai.document.Document;
import org.springframework.ai.openai.OpenAiChatModel;
import org.springframework.ai.openai.OpenAiChatOptions;
import org.springframework.ai.openai.api.OpenAiApi;
import org.springframework.ai.reader.pdf.PagePdfDocumentReader;
import org.springframework.ai.reader.pdf.config.PdfDocumentReaderConfig;
import org.springframework.ai.transformer.splitter.TokenTextSplitter;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import ucad.sn.assistanceservice.services.AssistanceService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class AssistanceServiceImpl implements AssistanceService {
    private final VectorStore vectorStore;
    private final JdbcTemplate jdbcTemplate;
    private final ChatClient chatClient;
   @Value("${spring.ai.openai.api-key}")
    String OPEN_AI_KEY;
    public AssistanceServiceImpl(VectorStore vectorStore, JdbcTemplate jdbcTemplate, ChatClient.Builder builder) {
        this.vectorStore = vectorStore;
        this.jdbcTemplate = jdbcTemplate;
        this.chatClient = builder.build();
    }
/*Specifique aux models de Open Ai tels que gpt 4o, turbo et les autres*/
    @Override
    public String ragQueryOpenAi(String query) {
        List<Document> returnedocuments = this.vectorStore.similaritySearch(query);
        String systemMessageTemplate="""
                Answer the following question based only on the provided CONTEXT
                CONTEXT: {CONTEXT}
                """;
        Message systemeMessage=new SystemPromptTemplate(systemMessageTemplate).createMessage(Map.of("CONTEXT",returnedocuments));
        UserMessage userMessage=new UserMessage(query);
        Prompt prompt=new Prompt(List.of(systemeMessage, userMessage));
        OpenAiApi openAiApi=new OpenAiApi(OPEN_AI_KEY);
        OpenAiChatModel model=new OpenAiChatModel(openAiApi, OpenAiChatOptions.
                builder().
                withModel(OpenAiApi.ChatModel.GPT_3_5_TURBO).
                withTemperature(0.2F).
                build());
        ChatResponse chatResponse = model.call(prompt);
        return chatResponse.getResult().getOutput().getContent();
    }
    /*Specifique aux model open source Ollama tels que mistral, llama2 et les autres*/
    /*@Override
    public String ragQueryOllama(String query) {
        List<Document> returnedocuments = vectorStore.similaritySearch(query);
        String systemMessageTemplate="""
                Answer the following question based only on the provided CONTEXT
                CONTEXT: {CONTEXT}
                """;
        Message systemeMessage=new SystemPromptTemplate(systemMessageTemplate).createMessage(Map.of("CONTEXT",returnedocuments));
        UserMessage userMessage=new UserMessage(query);
        Prompt prompt=new Prompt(List.of(systemeMessage, userMessage));
        OllamaApi ollamaApi=new OllamaApi();
        OllamaChatModel model=new OllamaChatModel(ollamaApi,
                OllamaOptions.
                        create().
                        withTemperature(0.2F).
                        withModel(OllamaModel.MISTRAL).
                        withTopK(5));
        ChatResponse chatResponse = model.call(prompt);
       return chatResponse.getResult().getOutput().getContent();
    }*/
/*Cette methode permet d'intergir avec n'importe quel model definie dans le fichier
    applicatio.properties. Cette objet chatClient est une interface qui peut etre
    utilisé avec tous les models. Il suffira alors de definir les configurations
    telles que le model, la temperatures et les autres proprietes dans le app.propertie
   */ @Override
    public Flux<String> ragQueryWithAllModel(String query) {
        List<Document> returnedocuments = vectorStore.similaritySearch(query);
        String systemMessageTemplate="""
                You are a virtual assistant who answers questions from users of the teranga connect platform.
                 Answer questions based solely on the context provided. 
                 If the question concerns sensitive data, answer with:
                  I can't give you the answer to this sensitive question. 
                 If the question does not concern the context, answer with Sorry, 
                 the question does not concern this context. 
                 Take language into account by providing the answer in the same language as the question.
                CONTEXT: {CONTEXT}
                """;
        Message systemeMessage=new SystemPromptTemplate(systemMessageTemplate).createMessage(Map.of("CONTEXT",returnedocuments));
        UserMessage userMessage=new UserMessage(query);
        Prompt prompt=new Prompt(List.of(systemeMessage, userMessage));

        return chatClient.prompt(prompt).stream().content();
    }
    /*cette methode est appelé au démarrage de l'application et permet de transformer le contenu
    * du dossier spécifié en vecteurs qui seront enregistré dans la base de données vectorielles*/

    @Override
    public void splitChunksEmbedAnsStore(Resource[] pfdResources) {
        initAnkanePgVectore(jdbcTemplate);
        PdfDocumentReaderConfig config = PdfDocumentReaderConfig.defaultConfig();
        List<Document> allDocuments = new ArrayList<>();

        for (Resource resource : pfdResources) {
            System.out.println("Processing resource: " + resource.getFilename());
            PagePdfDocumentReader pagePdfDocumentReader = new PagePdfDocumentReader(resource, config);
            List<Document> documents = pagePdfDocumentReader.get();
            allDocuments.addAll(documents);

        }

        System.out.println("Splitting documents into chunks");
        TokenTextSplitter splitter = new TokenTextSplitter();
        List<Document> chunks = splitter.split(allDocuments);
        System.out.println("Number of chunks: " + chunks.size());

        System.out.println("Storing chunks in vector store");
        vectorStore.accept(chunks);

        System.out.println("Process completed");
    }
    private  void initAnkanePgVectore(JdbcTemplate jdbcTemplate) {
        boolean extensionExists = jdbcTemplate.query(
                "SELECT 1 FROM pg_extension WHERE extname = 'vector'",
                (rs, rowNum) -> rs.getInt(1)
        ).size() > 0;

        if (!extensionExists) {
            jdbcTemplate.execute("CREATE EXTENSION IF NOT EXISTS vector");
        }

        jdbcTemplate.execute("""
        CREATE TABLE IF NOT EXISTS vector_store (
            id UUID PRIMARY KEY,
            content TEXT,
            embedding VECTOR(1536),
            metadata JSONB
        )
    """);
        jdbcTemplate.update("DELETE FROM vector_store");
    }

}
