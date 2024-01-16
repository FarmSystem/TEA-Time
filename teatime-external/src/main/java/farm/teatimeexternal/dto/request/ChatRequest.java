package farm.teatimeexternal.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

import java.util.List;

@Builder
public record ChatRequest(
        @JsonProperty("model") String model,
        @JsonProperty("messages") List<Message> messages,
        @JsonProperty("n") Integer n,
        @JsonProperty("temperature") Double temperature
        ) {
    public static ChatRequest of(String model, List<Message> messages) {
        return ChatRequest.builder()
                .model(model)
                .messages(messages)
                .n(null)
                .temperature(null)
                .build();
    }
}
