package farm.teatimeapi.dto.community.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Diary;
import io.swagger.v3.oas.annotations.media.Schema;

public record DiaryTokenDto (
        @JsonProperty("diary_id")
        @Schema(name = "diary_id", description = "다이어리 ID")
        Long diaryId,

        @JsonProperty("diary_image")
        @Schema(name = "diary_image", description = "다이어리 이미지")
        String diaryImage
) {
    public static DiaryTokenDto fromEntity(Diary diary) {
        return new DiaryTokenDto(
                diary.getId(),
                diary.getImage()
        );
    }
}
