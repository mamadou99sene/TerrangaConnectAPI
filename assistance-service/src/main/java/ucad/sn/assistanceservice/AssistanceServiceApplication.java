package ucad.sn.assistanceservice;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.Resource;
import org.springframework.jdbc.core.JdbcTemplate;
import ucad.sn.assistanceservice.services.AssistanceService;

@SpringBootApplication
public class AssistanceServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(AssistanceServiceApplication.class, args);
    }
@Bean
CommandLineRunner commandLineRunner(@Value("classpath:documents/*") Resource[] pdfresources,  AssistanceService assistanceService, JdbcTemplate jdbcTemplate)
    {
        return args -> {
            assistanceService.splitChunksEmbedAnsStore(pdfresources);
        };
    }
    /*private static void splitToChunksEmbeddAndStore(VectorStore vectorStore, JdbcTemplate jdbcTemplate, Resource[] pdfresources)
    {
        System.out.println("begin split to chunks, embedding and store in the vectorial database");
        jdbcTemplate.execute("CREATE EXTENSION vector");
        jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS vector_store (id SERIAL PRIMARY KEY, content TEXT, embedding VECTOR(1536))");

        jdbcTemplate.update("DELETE FROM vector_store");

        PdfDocumentReaderConfig config = PdfDocumentReaderConfig.defaultConfig();
        List<Document> allDocuments = new ArrayList<>();

        for (Resource resource : pdfresources) {
            System.out.println("Processing resource: " + resource.getFilename());
            PagePdfDocumentReader pagePdfDocumentReader = new PagePdfDocumentReader(resource, config);
            List<Document> documents = pagePdfDocumentReader.get();
            allDocuments.addAll(documents);
            allDocuments.stream().map(document ->
            {

                {
                    System.out.println(document.getContent());
                }
                return null;
            });
        }

        System.out.println("Splitting documents into chunks");
        TokenTextSplitter splitter = new TokenTextSplitter();
        List<Document> chunks = splitter.split(allDocuments);
        System.out.println("Number of chunks: " + chunks.size());

        System.out.println("Storing chunks in vector store");
        vectorStore.add(chunks);

        System.out.println("Process completed");
    }*/
    /*private static void ragQueryOpenAI(VectorStore vectorStore) {
        String query="Donner ce que vous savez de cette plateforme";
        List<Document> returnedocuments = vectorStore.similaritySearch(query);
        String systemMessageTemplate="""
                Answer the following question based only on the provided CONTEXT
                CONTEXT: {CONTEXT}
                """;
        Message systemeMessage=new SystemPromptTemplate(systemMessageTemplate).createMessage(Map.of("CONTEXT",returnedocuments));
        UserMessage userMessage=new UserMessage(query);
        Prompt prompt=new Prompt(List.of(systemeMessage, userMessage));
        OpenAiApi openAiApi=new OpenAiApi("key");
        OpenAiChatModel model=new OpenAiChatModel(openAiApi, OpenAiChatOptions.
                builder().
                withModel("gpt-4o").
                withTemperature(0.2F).
                build());
        ChatResponse chatResponse = model.call(prompt);
        System.out.println(chatResponse.getResult().getOutput().getContent());
    }
    private static void ragQueryOllama(VectorStore vectorStore) {
        String query="Donner ce que vous savez de cette plateforme";
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
                        withModel(OllamaModel.LLAMA2).
                        withTopK(5));
        ChatResponse chatResponse = model.call(prompt);
        System.out.println(chatResponse.getResult().getOutput().getContent());
    }*/
}
