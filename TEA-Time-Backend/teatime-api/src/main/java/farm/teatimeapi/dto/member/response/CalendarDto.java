package farm.teatimeapi.dto.member.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Diary;
import lombok.Builder;

@Builder
public record CalendarDto(
        @JsonProperty("id") Long diaryId,
        @JsonProperty("created_at") String createdAt,
        @JsonProperty("emotion_score") Float emotionScore
) {
    public static CalendarDto fromEntity(Diary diary) {
        return CalendarDto.builder()
                .diaryId(diary.getId())
                .createdAt(diary.getCreatedAt().toString())
                .emotionScore(diary.getAnalysis().getScore())
                .build();
    }
}
