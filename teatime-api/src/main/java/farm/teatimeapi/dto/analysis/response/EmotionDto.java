package farm.teatimeapi.dto.analysis.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Analysis;
import io.swagger.v3.oas.annotations.media.Schema;

public record EmotionDto(
        @JsonProperty("happy")
        @Schema(name = "happy", description = "행복 비율")
        float happy,

        @JsonProperty("embarrassment")
        @Schema(name = "embarrassment", description = "당황 비율")
        float embarrassment,

        @JsonProperty("anger")
        @Schema(name = "anger", description = "화남 비율")
        float anger,

        @JsonProperty("anxiety")
        @Schema(name = "anxiety", description = "불안 비율")
        float anxiety,

        @JsonProperty("sadness")
        @Schema(name = "sadness", description = "슬픔 비율")
        float sadness
) {
    public static EmotionDto fromEntity(Analysis analysis) {
        return new EmotionDto(
                analysis.getHappy(),
                analysis.getEmbarrassment(),
                analysis.getAnger(),
                analysis.getAnxiety(),
                analysis.getSadness()
        );
    }
}
