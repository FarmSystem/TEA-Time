package farm.teatimeapi.dto.auth.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(name = "AuthSignUpDto", description = "회원가입 요청")
public record AuthSignUpDto(
        @JsonProperty("email")
        @Schema(description = "이메일", example = "FarmSystem@Dongguk")
        String email,

        @JsonProperty("password")
        @Schema(description = "비밀번호", example = "1234567890")
        String password,

        @Schema(description = "닉네임", example = "박상준")
        String nickname
) {
}
