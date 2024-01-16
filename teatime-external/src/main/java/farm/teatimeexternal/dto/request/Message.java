package farm.teatimeexternal.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

@Builder
public record Message(
        @JsonProperty("role") String role,
        @JsonProperty("content") String content
) {
    public static Message of(String role, String content) {
        return Message.builder()
                .role(role)
                .content(content)
                .build();
    }
}
