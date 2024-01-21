package farm.teatimeapi.dto.member.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimedomain.domain.Diary;
import farm.teatimedomain.domain.User;
import lombok.Builder;

@Builder
public record MemberInfoDto (
        @JsonProperty("nickname") String nickname,
        @JsonProperty("introduction") String introduction,
        @JsonProperty("profile_image") String profileImage,
        @JsonProperty("diary_count") long diaryCount,
        @JsonProperty("user_level") Integer userLevel,
        @JsonProperty("user_score") Integer userScore
) {
    public static MemberInfoDto fromEntity(User user, Long diaryCount) {
        return MemberInfoDto.builder()
                .nickname(user.getNickname())
                .introduction(user.getIntroduction())
                .profileImage(user.getProfileImage())
                .diaryCount(diaryCount)
                .userLevel(user.getLevel())
                .userScore(user.getScore())
                .build();

    }
}
