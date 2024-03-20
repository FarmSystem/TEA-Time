package farm.teatimeapi.dto.community.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.User;
import io.swagger.v3.oas.annotations.media.Schema;

public record MemberDto(
        @JsonProperty("user_id")
        @Schema(name = "user_id", description = "유저 ID")
        Long userId,

        @JsonProperty("nickname")
        @Schema(name = "nickname", description = "닉네임")
        String nickname,

        @JsonProperty("profile_image")
        @Schema(name = "profile_image", description = "프로필 이미지")
        String profileImage,

        @JsonProperty("diary_number")
        @Schema(name = "diary_number", description = "다이어리 개수")
        int diaryNumber
) {
    public static MemberDto fromEntity(User user) {
        return new MemberDto(
                user.getId(),
                user.getNickname(),
                user.getProfileImage(),
                user.getDiaries().size()
        );
    }
}
