package farm.teatimeapi.dto.analysis.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Diary;

public record AnalysisDto(
        @JsonProperty("created_at") String createdAt,
        @JsonProperty("emotion_score") float emotionScore
) {
    public static AnalysisDto fromEntity(Diary diary) {
        return new AnalysisDto(
                diary.getCreatedAt().toString(),
                diary.getAnalysis().getScore()
        );
    }
}
