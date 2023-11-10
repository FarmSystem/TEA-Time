package com.farm.api.oauth;

import com.farm.api.domain.EnumType.LoginPlatform;
import com.farm.api.domain.EnumType.UserType;
import com.farm.api.domain.User;
import com.farm.api.dto.jwt.JwtResponseDto;
import com.farm.api.exception.CustomException;
import com.farm.api.exception.ErrorCode;
import com.farm.api.repository.UserRepository;
import com.farm.api.security.jwt.JwtProvider;
import com.farm.api.security.jwt.JwtToken;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class AuthService {
    private final UserRepository userRepository;
    private final JwtProvider jwtProvider;
    private final OAuth2Utils oAuth2Utils;

    public String getRedirectUrl(LoginPlatform loginProvider) {
        switch (loginProvider) {
            case KAKAO -> {
                return oAuth2Utils.getKakaoRedirectUrl();
            }
            case GOOGLE -> {
                return oAuth2Utils.getGoogleRedirectUrl();
            }
        }
        return null;
    }

    public String getAccessToken(String authorizationCode, LoginPlatform provider) {
        String accessToken = null;
        switch (provider) {
            case KAKAO -> {
                accessToken = oAuth2Utils.getKakaoAccessToken(authorizationCode);
            }
            case GOOGLE -> {
                accessToken = oAuth2Utils.getGoogleAccessToken(authorizationCode);
            }
        }
        return accessToken;
    }

    public JwtResponseDto login(String accessToken, LoginPlatform provider) {
        String tempId = null;
        switch (provider) {
            case KAKAO -> {
                tempId = oAuth2Utils.getKakaoUserInfo(accessToken);
            }
            case GOOGLE -> {
                tempId = oAuth2Utils.getGoogleUserInfo(accessToken);
            }
        }

        if (tempId == null) {
            throw new CustomException(ErrorCode.NOT_FOUND_USER);
        }

        Random random = new Random();
        final String socialId = tempId;
        final String password = UUID.randomUUID().toString();

        User user = userRepository.findBySocialIdAndProvider(socialId, provider)
                .orElseGet(() -> {
                    String nickName = provider.toString() + "_" + random.nextInt(1000000);

                    return userRepository.save(User.builder()
                            .socialId(socialId)
                            .nickname(nickName)
                            .password(password)
                            .profileUrl("default")
                            .provider(provider)
                            .userType(UserType.USER)
                            .build());
                });

        JwtToken jwtToken = jwtProvider.createTokens(user.getSocialId(), user.getUserType());

        user.updateRefreshToken(jwtToken.getRefreshToken());

        return JwtResponseDto.builder()
                .jwtToken(jwtToken)
                .build();
    }

    public Boolean logout(String socialId) {
        User user = userRepository.findBySocialIdAndIsLogin(socialId, true)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        user.logoutUser();
        return true;
    }

    public Map<String, String> getAccessTokenByRefreshToken(HttpServletRequest request) {
        Map<String, String> map = new HashMap<>();
        map.put("access_token", jwtProvider.validateRefreshToken(request));
        return map;
    }
}
