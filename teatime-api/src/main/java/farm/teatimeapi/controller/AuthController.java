package farm.teatimeapi.controller;

import farm.teatimeapi.dto.auth.request.AuthSignUpDto;
import farm.teatimeapi.dto.jwt.response.JwtTokenDto;
import farm.teatimeapi.service.AuthService;
import farm.teatimeapi.utils.CookieUtil;
import farm.teatimeapi.utils.HeaderUtil;
import farm.teatimecore.annotation.UserId;
import farm.teatimecore.contrant.Constants;
import farm.teatimecore.dto.ResponseDto;
import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/auth")
@Tag(name = "Auth", description = "인증 관련 API")
public class AuthController {
    private final AuthService authService;

    @PostMapping("/sign-up")
    public ResponseDto<?> signUp(@RequestBody @Valid AuthSignUpDto authSignUpDto) {
        authService.signUp(authSignUpDto);
        return ResponseDto.created(null);
    }

    @PostMapping("/reissue")
    public ResponseDto<?> reissue(HttpServletRequest request, HttpServletResponse response, @UserId Long userId) {
        String refreshToken = StringUtils.startsWith(request.getHeader("User-Agent"), "Dart") ?
                HeaderUtil.refineHeader(request, Constants.AUTHORIZATION_HEADER, Constants.BEARER_PREFIX)
                        .orElseThrow(() -> new CustomException(ErrorCode.MISSING_REQUEST_HEADER_ERROR))
                : CookieUtil.refineCookie(request, "refresh_token")
                .orElseThrow(() -> new CustomException(ErrorCode.MISSING_REQUEST_HEADER_ERROR));
        JwtTokenDto jwtTokenDto = authService.reissue(userId, refreshToken);

        if (request.getHeader("User-Agent") != null) {
            CookieUtil.addSecureCookie(response, "refresh_token", jwtTokenDto.refreshToken(), 60 * 60 * 24 * 14);
            jwtTokenDto = JwtTokenDto.of(jwtTokenDto.accessToken(), null);
        }

        return ResponseDto.ok(jwtTokenDto);
    }

    @GetMapping("/email")
    public ResponseDto<?> emailDuplication(@RequestParam String email) {
        return ResponseDto.ok(authService.emailDuplication(email));
    }

    @GetMapping("/nickname")
    public ResponseDto<?> nicknameDuplication(@RequestParam String nickname) {
        return ResponseDto.ok(authService.nicknameDuplication(nickname));
    }
}
