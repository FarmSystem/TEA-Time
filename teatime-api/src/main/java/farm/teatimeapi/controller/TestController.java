package farm.teatimeapi.controller;

import com.fasterxml.jackson.annotation.JsonProperty;
import farm.teatimecore.annotation.UserId;
import farm.teatimecore.dto.ResponseDto;
import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import farm.teatimedomain.domain.User;
import farm.teatimedomain.reposiotry.UserRepository;
import lombok.Builder;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.Serializable;

@Slf4j
@RestController
@RequestMapping("/api/test")
@RequiredArgsConstructor
public class TestController {
    private final UserRepository userRepository;
    @GetMapping("")
    public ResponseDto<UserDto> getUser(
//            @UserId Long userId
    ) {
        Long userId = 2L;
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_LOGIN_USER));
        return ResponseDto.ok(UserDto.of(user.getNickname(), user.getId()));
    }

    @Builder
    public record UserDto(
            @JsonProperty("nickname")
            String nickname,

            @JsonProperty("user_id")
            Long id
    ) implements Serializable {
        public static UserDto of (String nickname, Long id) {
            return UserDto.builder()
                    .nickname(nickname)
                    .id(id)
                    .build();
        }
    }
}
