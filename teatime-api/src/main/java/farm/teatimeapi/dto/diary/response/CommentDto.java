package farm.teatimeapi.dto.diary.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Comment;
import io.swagger.v3.oas.annotations.media.Schema;

import java.util.List;

public record CommentDto (
        @JsonProperty("user_id")
        @Schema(name = "user_id", description = "유저 ID")
        Long userId,

        @JsonProperty("profile_image")
        @Schema(name = "profile_image", description = "프로필 이미지")
        String profileImage,

        @JsonProperty("nickname")
        @Schema(name = "nickname", description = "닉네임")
        String nickname,

        @JsonProperty("content")
        @Schema(name = "content", description = "댓글 내용")
        String content,

        @JsonProperty("created_at")
        @Schema(name = "created_at", description = "댓글 생성 시간")
        String createdAt
) {
    public static CommentDto fromEntity(Comment comment) {
        return new CommentDto(
                comment.getUser().getId(),
                comment.getUser().getProfileImage(),
                comment.getUser().getNickname(),
                comment.getContent(),
                comment.getCreatedAt().toString()
        );
    }
}
