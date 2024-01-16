package farm.teatimeexternal.utils;

import farm.teatimeexternal.dto.request.ChatRequest;
import farm.teatimeexternal.dto.request.Message;
import farm.teatimeexternal.dto.response.ChatResponse;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Component
public class OpenAIUtil {
    private final RestTemplate restTemplate;

    @Value("${openai.model}")
    private String model;

    @Value("${openai.api.url}")
    private String apiUrl;

    @Value("${openai.emotion-query}")
    private String emotionQuery;

    public OpenAIUtil(@Qualifier("openaiRestTemplate") RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public String consultant(String content, String score) {
        List<Message> messages = List.of(
                Message.of("system", emotionQuery),
                Message.of("user", content),
                Message.of("user", score)
        );

        ChatRequest request = ChatRequest.of(model, messages);

        ChatResponse response = restTemplate.postForObject(apiUrl, request, ChatResponse.class);

        if (response == null || response.choices() == null || response.choices().isEmpty()) {
            return null;
        }

        return response.choices().get(0).message().content();
    }
}

