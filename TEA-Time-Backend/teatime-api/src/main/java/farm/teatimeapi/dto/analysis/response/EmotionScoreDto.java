package farm.teatimeapi.dto.analysis.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Diary;

public record EmotionScoreDto(
        @JsonProperty("score") float score
) {
    public static EmotionScoreDto fromEntity(Diary diary) {
        return new EmotionScoreDto(
                diary.getAnalysis().getScore()
        );
    }
}
