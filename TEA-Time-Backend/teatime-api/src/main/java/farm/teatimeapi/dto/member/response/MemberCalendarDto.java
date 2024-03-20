package farm.teatimeapi.dto.member.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Diary;
import lombok.Builder;

import java.util.List;

@Builder
public record MemberCalendarDto(
        @JsonProperty("calendar") List<CalendarDto> calendar
) {
    public static MemberCalendarDto fromEntity(List<Diary> diaries) {
        return MemberCalendarDto.builder()
                .calendar(diaries.stream().map(CalendarDto::fromEntity).toList())
                .build();
    }
}
