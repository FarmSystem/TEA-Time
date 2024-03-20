package farm.teatimeapi.dto.member.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;

public record UpdateUserinfoDto (
        @JsonProperty("nickname")
        @Schema(name = "nickname", description = "닉네임")
        String nickname,

        @JsonProperty("introduction")
        @Schema(name = "introduction", description = "자기소개")
        String introduction,

        @JsonProperty("is_public")
        @Schema(name = "is_public", description = "공개 여부")
        boolean isPublic
) {
}
