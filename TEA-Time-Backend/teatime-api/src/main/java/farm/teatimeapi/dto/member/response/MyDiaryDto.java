package farm.teatimeapi.dto.member.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimeapi.dto.community.response.DiaryTokenDto;
import farm.teatimedomain.domain.Diary;
import lombok.Builder;

import java.util.List;

@Builder
public record MyDiaryDto(
        @JsonProperty("diaries")List<DiaryTokenDto> diaries
        ) {
    public static MyDiaryDto fromEntity(List<Diary> diaries) {
        return MyDiaryDto.builder()
                .diaries(diaries.stream().map(DiaryTokenDto::fromEntity).toList())
                .build();
    }
}
