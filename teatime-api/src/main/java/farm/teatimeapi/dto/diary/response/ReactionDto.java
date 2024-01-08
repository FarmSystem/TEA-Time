package farm.teatimeapi.dto.diary.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Reaction;
import io.swagger.v3.oas.annotations.media.Schema;

public record ReactionDto(
        @JsonProperty("user_id")
        @Schema(name = "user_id", description = "유저 ID")
        Long userId,

        @JsonProperty("profile_image")
        @Schema(name = "profile_image", description = "프로필 이미지")
        String profileImage,

        @JsonProperty("nickname")
        @Schema(name = "nickname", description = "닉네임")
        String nickname
) {
    public static ReactionDto fromEntity(Reaction reaction) {
        return new ReactionDto(
                reaction.getUser().getId(),
                reaction.getUser().getProfileImage(),
                reaction.getUser().getNickname()
        );
    }
}
