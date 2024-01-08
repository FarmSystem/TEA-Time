package farm.teatimeapi.dto.diary.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(name = "CreateDiaryDto", description = "일기 생성 요청")
public record CreateDiaryDto(
        @JsonProperty("title")
        @Schema(description = "제목", example = "오늘의 일기")
        String title,
        @JsonProperty("content")
        @Schema(description = "내용", example = "오늘은 무엇을 했나요?")
        String content
) {
}
