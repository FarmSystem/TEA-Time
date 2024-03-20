package farm.teatimeapi.security.handler.signin;

import com.google.gson.Gson;
import farm.teatimeapi.dto.jwt.response.JwtTokenDto;
import farm.teatimeapi.security.info.UserPrincipal;
import farm.teatimeapi.utils.CookieUtil;
import farm.teatimeapi.utils.JwtUtil;
import farm.teatimedomain.reposiotry.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Component
@RequiredArgsConstructor
public class DefaultSuccessHandler implements AuthenticationSuccessHandler {
    private final JwtUtil jwtUtil;
    private final UserRepository userRepository;
    @Override
    @Transactional
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        UserPrincipal userPrincipal = (UserPrincipal) authentication.getPrincipal();
        JwtTokenDto tokenDto = jwtUtil.generateTokens(userPrincipal.getId(), userPrincipal.getRole());
        userRepository.updateRefreshTokenAndLoginStatus(userPrincipal.getId(), tokenDto.refreshToken(), true);

        String userAgent = request.getHeader("User-Agent");

        if (StringUtils.startsWith(userAgent, "Dart")) {
            setSuccessAppResponse(response, tokenDto);
        } else {
            setSuccessWebResponse(response, tokenDto);
        }
    }

    private void setSuccessAppResponse(HttpServletResponse response, JwtTokenDto tokenDto) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpStatus.OK.value());

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("data", Map.of(
                "access_token", tokenDto.accessToken(),
                "refresh_token", tokenDto.refreshToken()
                )
        );
        result.put("error", null);

        Gson gson = new Gson();
        response.getWriter().write(gson.toJson(result));
    }

    private void setSuccessWebResponse(HttpServletResponse response, JwtTokenDto tokenDto) throws IOException {
        CookieUtil.addCookie(response, "access_token", tokenDto.accessToken());
        CookieUtil.addSecureCookie(response, "refresh_token", tokenDto.refreshToken(), jwtUtil.getRefreshTokenExpire());
        response.sendRedirect("/");
    }
}
