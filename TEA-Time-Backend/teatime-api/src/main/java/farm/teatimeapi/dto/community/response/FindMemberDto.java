package farm.teatimeapi.dto.community.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.User;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;

import java.util.List;

@Builder
public record FindMemberDto(
        @JsonProperty("member")
        @Schema(name = "member", description = "추천 회원 목록")
        List<MemberDto> members
) {
    public static FindMemberDto fromEntity(List<User> users) {
        return FindMemberDto.builder()
                .members(users.stream().map(MemberDto::fromEntity).toList())
                .build();
    }
}
