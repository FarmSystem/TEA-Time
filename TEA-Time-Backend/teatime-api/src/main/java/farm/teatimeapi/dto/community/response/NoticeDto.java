package farm.teatimeapi.dto.community.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;

public record NoticeDto (
        @JsonProperty("user_id")
        @Schema(name = "user_id", description = "유저 ID")
        Long userId,

        @JsonProperty("nickname")
        @Schema(name = "nickname", description = "닉네임")
        String nickname,

        @JsonProperty("profile_image")
        @Schema(name = "profile_image", description = "프로필 이미지")
        String profileImage,

        @JsonProperty("created_at")
        @Schema(name = "created_at", description = "생성 날짜")
        String createdAt,

        @JsonProperty("is_comment")
        @Schema(name = "is_comment", description = "알림이 댓글에 대한 알림인지 반응에 대한 알림인지")
        boolean isComment
) {
}
