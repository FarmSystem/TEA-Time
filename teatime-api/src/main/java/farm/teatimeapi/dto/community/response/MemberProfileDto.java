package farm.teatimeapi.dto.community.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Diary;
import farm.teatimedomain.domain.User;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;

import java.util.List;

@Builder
public record MemberProfileDto (
        @JsonProperty("user_id")
        @Schema(name = "user_id", description = "유저 ID")
        Long userId,

        @JsonProperty("profile_image")
        @Schema(name = "profile_image", description = "프로필 이미지")
        String profileImage,

        @JsonProperty("nickname")
        @Schema(name = "nickname", description = "닉네임")
        String nickname,

        @JsonProperty("following")
        @Schema(name = "following", description = "팔로잉 수")
        int following,

        @JsonProperty("follower")
        @Schema(name = "follower", description = "팔로워 수")
        int follower,

        @JsonProperty("diaries")
        @Schema(name = "diaries", description = "다이어리")
        List<DiaryTokenDto> diaries
) {
    public static MemberProfileDto fromEntity(User user, List<Diary> diaries) {
        return MemberProfileDto.builder()
                .userId(user.getId())
                .profileImage(user.getProfileImage())
                .nickname(user.getNickname())
                .diaries(diaries.stream().map(DiaryTokenDto::fromEntity).toList())
                .build();
    }
}
