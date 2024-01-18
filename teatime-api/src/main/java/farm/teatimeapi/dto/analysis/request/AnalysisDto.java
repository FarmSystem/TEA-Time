package farm.teatimeapi.dto.analysis.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Diary;

public record AnalysisDto(
        @JsonProperty("content") String content,
        @JsonProperty("score") float score,
        @JsonProperty("happy") float happy,
        @JsonProperty("embarrassment") float embarrassment,
        @JsonProperty("anger") float anger,
        @JsonProperty("anxiety") float anxiety,
        @JsonProperty("sadness") float sadness

) {
    public static AnalysisDto fromEntity(Diary diary) {
        return new AnalysisDto(
                diary.getContent(),
                diary.getAnalysis().getScore(),
                diary.getAnalysis().getHappy(),
                diary.getAnalysis().getEmbarrassment(),
                diary.getAnalysis().getAnger(),
                diary.getAnalysis().getAnxiety(),
                diary.getAnalysis().getSadness()
        );
    }
}
