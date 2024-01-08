package farm.teatimeapi.dto.diary.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Diary;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AccessLevel;
import lombok.Builder;

import java.util.List;

@Builder(access = AccessLevel.PRIVATE)
public record DiaryDetailDto (
        @JsonProperty("diary_id")
        @Schema(name = "diary_id", description = "다이어리 ID")
        Long diaryId,

        @JsonProperty("title")
        @Schema(name = "title", description = "다이어리 제목")
        String title,

        @JsonProperty("profile_image")
        @Schema(name = "profile_image", description = "프로필 이미지")
        String profileImage,

        @JsonProperty("nickname")
        @Schema(name = "nickname", description = "닉네임")
        String nickname,

        @JsonProperty("content")
        @Schema(name = "content", description = "다이어리 내용")
        String content,

        @JsonProperty("diary_image")
        @Schema(name = "diary_image", description = "다이어리 이미지")
        String diaryImage,

        @JsonProperty("created_at")
        @Schema(name = "created_at", description = "다이어리 생성 시간")
        String createdAt,

        @JsonProperty("comments")
        @Schema(name = "comments", description = "댓글 목록")
        List<CommentDto> comments,

        @JsonProperty("reactions")
        @Schema(name = "reactions", description = "반응 목록")
        List<ReactionDto> reactions
) {
    public static DiaryDetailDto fromEntity(Diary diary) {
        return DiaryDetailDto.builder()
                .diaryId(diary.getId())
                .title(diary.getTitle())
                .profileImage(diary.getUser().getProfileImage())
                .nickname(diary.getUser().getNickname())
                .content(diary.getContent())
                .diaryImage(diary.getImage())
                .createdAt(diary.getCreatedAt().toString())
                .comments(diary.getComments().stream().map(CommentDto::fromEntity).toList())
                .reactions(diary.getReactions().stream().map(ReactionDto::fromEntity).toList())
                .build();
    }
}
