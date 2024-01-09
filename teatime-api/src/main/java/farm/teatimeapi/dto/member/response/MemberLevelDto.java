package farm.teatimeapi.dto.member.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.User;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;

@Builder
public record MemberLevelDto (
        @JsonProperty("level")
        @Schema(name = "level", description = "레벨")
        int level,

        @JsonProperty("score")
        @Schema(name = "score", description = "점수")
        int score
) {
    public static MemberLevelDto fromEntity(User user) {
        return MemberLevelDto.builder()
                .level(user.getLevel())
                .score(user.getScore())
                .build();
    }
}
