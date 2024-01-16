package farm.teatimeexternal.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public record ChatResponse(
        @JsonProperty("choices")List<Choice> choices
        ) {
}
