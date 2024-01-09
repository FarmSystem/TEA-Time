package farm.teatimeapi.dto.community.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Diary;
import lombok.Builder;

import java.util.List;

@Builder
public record GetCommunityDto(
        @JsonProperty("diary")
        List<CommunityDto> diaries
) {
    public static GetCommunityDto fromEntity(List<Diary> diaries) {
        return GetCommunityDto.builder()
                .diaries(diaries.stream().map(CommunityDto::fromEntity).toList())
                .build();
    }
}
