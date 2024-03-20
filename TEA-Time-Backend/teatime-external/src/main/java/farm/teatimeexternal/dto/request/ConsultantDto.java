package farm.teatimeexternal.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

public record ConsultantDto (
        @JsonProperty("content") String content,
        @JsonProperty("score") Double score,
        @JsonProperty("happy") Double happy,
        @JsonProperty("sadness") Double sadness,
        @JsonProperty("anger") Double anger,
        @JsonProperty("anxiety") Double anxiety,
        @JsonProperty("embarrassment") Double embarrassment
) {
}
