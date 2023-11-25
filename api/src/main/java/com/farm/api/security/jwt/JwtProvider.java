package com.farm.api.security.jwt;

import com.farm.api.domain.EnumType.UserType;
import com.farm.api.domain.User;
import com.farm.api.repository.UserRepository;
import io.jsonwebtoken.*;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.security.Key;
import java.util.Date;

@Slf4j
@Component
@RequiredArgsConstructor
public class JwtProvider implements InitializingBean {
    private final UserRepository userRepository;

    @Value("${security.jwt.secret}")
    private String secretKey;

    private Key key;

    @Value("${security.jwt.access.expiration}")
    private Long accessExpire;

    @Value("${security.jwt.refresh.expiration}")
    private Long refreshExpire;

    @Override
    public void afterPropertiesSet() throws Exception {
        byte [] keyBytes = Decoders.BASE64.decode(secretKey);
        this.key = Keys.hmacShaKeyFor(keyBytes);
    }

    /**
     * Generate Token
     */
    public String createToken(String socialId, UserType userType, boolean isAccess) {
        Claims claims = Jwts.claims();
        claims.put("id", socialId);
        if (isAccess) {
            claims.put("userType", userType);
        }

        return Jwts.builder()
                .setHeaderParam(Header.TYPE, Header.JWT_TYPE)
                .setClaims(claims)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + (isAccess ? accessExpire : refreshExpire)))
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();
    }

    /**
     * Generate Access Token and Refresh Token
     */
    public JwtToken createTokens(String socialId, UserType userType) {

        // Access Token 생성
        String accessToken = createToken(socialId, userType, true);

        // Refresh Token 생성
        String refreshToken = createToken(socialId, userType, false);

        return JwtToken.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .build();
    }

    /**
     * Validation Checking about Refresh Token
     */
    public String validateRefreshToken(HttpServletRequest request) throws JwtException {
        String refreshToken = resolveToken(request);
        Claims claims = validateToken(refreshToken);

        User user = userRepository.findBySocialIdAndRefreshToken(claims.get("id", String.class), refreshToken)
                .orElseThrow(() -> new JwtException("USER_NOT_FOUND"));

        return createToken(user.getSocialId(), user.getUserType(), true);
    }

    public String getSocialId(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token)
                .getBody()
                .get("id", String.class);
    }

    public Claims validateToken(String token) throws JwtException {
        return Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    public static String resolveToken(HttpServletRequest request) throws JwtException {
        String token = request.getHeader("Authorization");
        String newToken = null;

        if (StringUtils.hasText(token) && token.startsWith("Bearer ")) {
            newToken = token.substring(7);
        } else {
            throw new JwtException("TOKEN_NOT_FOUND");
        }
        return newToken;
    }
}
