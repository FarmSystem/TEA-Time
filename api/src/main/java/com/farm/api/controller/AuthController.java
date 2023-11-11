package com.farm.api.controller;

import com.farm.api.domain.EnumType.LoginPlatform;
import com.farm.api.dto.exception.ResponseDto;
import com.farm.api.dto.jwt.JwtResponseDto;
import com.farm.api.oauth.AuthService;
import com.farm.api.security.jwt.JwtProvider;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/v1/auth")
@Tag(name = "Auth", description = "Auth API")
@RequiredArgsConstructor
public class AuthController {
    private final AuthService authService;
    /**
     * @return Redirect URL
     */
    @GetMapping("/kakao")
    @Operation(summary = "Get Kakao Redirect URL", description = "Kakao OAuth2 서버에서 인증을 위한 code를 받아옵니다.")
    public ResponseDto<Map<String, String>> getKakaoRedirectUrl() {
        Map<String, String> map = new HashMap<>();
        map.put("url", authService.getRedirectUrl(LoginPlatform.KAKAO));
        return new ResponseDto<>(map);
    }

    @GetMapping("/google")
    @Operation(summary = "Get Google Redirect URL", description = "Google OAuth2 서버에서 인증을 위한 code를 받아옵니다.")
    public ResponseDto<Map<String, String>> getGoogleRedirectUrl() {
        Map<String, String> map = new HashMap<>();
        map.put("url", authService.getRedirectUrl(LoginPlatform.GOOGLE));
        return new ResponseDto<>(map);
    }

    /**
     * @param code
     * @return AccessToken
     */
    @GetMapping("/kakao/callback")
    @Operation(summary = "Get Kakao Access Token", description = "Kakao OAuth2 서버에서 Access Token을 받아옵니다.")
    public ResponseDto<String> getKakaoAccessToken(@RequestParam("code") String code) {
        return new ResponseDto<>(authService.getAccessToken(code, LoginPlatform.KAKAO));
    }

    @GetMapping("/google/callback")
    @Operation(summary = "Get Google Access Token", description = "Google OAuth2 서버에서 Access Token을 받아옵니다.")
    public ResponseDto<String> getGoogleAccessToken(@RequestParam("code") String code) {
        return new ResponseDto<>(authService.getAccessToken(code, LoginPlatform.GOOGLE));
    }

    /**
     * @return Access Token
     */
    @PostMapping("/kakao")
    @Operation(summary = "Login Kakao", description = "Kakao OAuth2 서버에서 받아온 Token을 통해 로그인을 진행 후 Access Token & Refresh Token을 발급합니다.")
    public ResponseDto<JwtResponseDto> loginKakao(HttpServletRequest request) {
        return new ResponseDto<>(authService.login(JwtProvider.resolveToken(request), LoginPlatform.KAKAO));
    }

    @PostMapping("/google")
    @Operation(summary = "Login Google", description = "Google OAuth2 서버에서 받아온 Token을 통해 로그인을 진행 후 Access Token & Refresh Token을 발급합니다.")
    public ResponseDto<JwtResponseDto> loginGoogle(HttpServletRequest request) {
        return new ResponseDto<>(authService.login(JwtProvider.resolveToken(request), LoginPlatform.GOOGLE));
    }

    @GetMapping("/logout")
    @Operation(summary = "Logout", description = "해당 사용자의 로그아웃을 진행합니다.")
    public ResponseDto<Boolean> logout(String socialId) {
        return new ResponseDto<>(authService.logout(socialId));
    }

    @PostMapping("/refresh")
    @Operation(summary = "Update Access Token", description = "Refresh Token을 통해 Access Token을 갱신합니다.")
    public ResponseDto<?> updateAccessToken(HttpServletRequest request) {
        return new ResponseDto<>(authService.getAccessTokenByRefreshToken(request));
    }
}
