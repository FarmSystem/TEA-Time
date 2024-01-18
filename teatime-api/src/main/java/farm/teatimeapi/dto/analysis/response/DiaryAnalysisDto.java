package farm.teatimeapi.dto.analysis.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Analysis;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;

@Builder
public record DiaryAnalysisDto (
        @JsonProperty("score")
        @Schema(name = "score", description = "감정 점수")
        float score,

        @JsonProperty("emotion")
        @Schema(name = "emotion", description = "감정")
        EmotionDto emotion,

        @JsonProperty("consultant")
        @Schema(name = "consultant", description = "조언")
        String consultant
) {
    public static DiaryAnalysisDto fromEntity(Analysis analysis, String consultant) {
        return DiaryAnalysisDto.builder()
                .score(analysis.getScore())
                .emotion(EmotionDto.fromEntity(analysis))
                .consultant(consultant)
                .build();
    }
}
