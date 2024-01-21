package farm.teatimeapi.dto.community.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Diary;
import io.swagger.v3.oas.annotations.media.Schema;

public record CommunityDto(

        @JsonProperty("user_id")
        @Schema(name = "user_id", description = "유저 ID")
        Long userId,
        @JsonProperty("diary_id")
        @Schema(name = "diary_id", description = "다이어리 ID")
        Long diaryId,
        @JsonProperty("title")
        @Schema(name = "title", description = "다이어리 제목")
        String title,

        @JsonProperty("nickname")
        @Schema(name = "nickname", description = "닉네임")
        String nickname,

        @JsonProperty("profile_image")
        @Schema(name = "profile_image", description = "프로필 이미지")
        String profileImage,

        @JsonProperty("diary_image")
        @Schema(name = "diary_image", description = "다이어리 이미지")
        String diaryImage,

        @JsonProperty("created_at")
        @Schema(name = "created_at", description = "다이어리 생성 시간")
        String createdAt
) {
        public static CommunityDto fromEntity(Diary diary) {
                return new CommunityDto(
                        diary.getUser().getId(),
                        diary.getId(),
                        diary.getTitle(),
                        diary.getUser().getNickname(),
                        diary.getUser().getProfileImage(),
                        diary.getImage(),
                        diary.getCreatedAt().toString()
                );
        }
}
