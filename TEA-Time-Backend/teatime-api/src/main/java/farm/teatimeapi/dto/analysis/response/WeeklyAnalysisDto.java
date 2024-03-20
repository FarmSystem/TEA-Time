package farm.teatimeapi.dto.analysis.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Diary;

import java.util.List;

public record WeeklyAnalysisDto(
        @JsonProperty("weekly_score")List<AnalysisDto> weeklyScore
        ) {
    public static WeeklyAnalysisDto fromEntity(List<Diary> diaries) {
        return new WeeklyAnalysisDto(
                diaries.stream()
                        .map(AnalysisDto::fromEntity)
                        .toList()
        );
    }
}
