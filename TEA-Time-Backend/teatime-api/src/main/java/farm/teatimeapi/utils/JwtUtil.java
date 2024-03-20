package farm.teatimeapi.utils;

import farm.teatimeapi.dto.jwt.response.JwtTokenDto;
import farm.teatimecore.contrant.Constants;
import farm.teatimedomain.type.ERole;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Header;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import lombok.Getter;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import io.jsonwebtoken.io.Decoders;
import java.security.Key;
import java.util.Date;

@Component
public class JwtUtil implements InitializingBean {
    @Value("${jwt.secret-key}")
    private String secretKey;
    @Value("${jwt.access-token-expire-period}")
    private Integer accessTokenExpire;
    @Value("${jwt.refresh-token-expire-period}")
    @Getter
    private Integer refreshTokenExpire;
    private Key key;
    @Override
    public void afterPropertiesSet() throws Exception {
        byte[] bytes = Decoders.BASE64.decode(secretKey);
        this.key = Keys.hmacShaKeyFor(bytes);
    }

    public JwtTokenDto generateTokens(Long userId, ERole role) {
        return new JwtTokenDto(
                generateToken(userId, role, accessTokenExpire * 1000),
                generateToken(userId, null, refreshTokenExpire * 1000)
        );
    }

    public Claims validateToken(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(token)
                .getBody();
    }

    private String generateToken(Long userId, ERole role, Integer expire) {
        Claims claims = Jwts.claims();
        claims.put(Constants.USER_ID_CLAIM_NAME, userId);
        if (role != null)
            claims.put(Constants.USER_ROLE_CLAIM_NAME, role);
        return Jwts.builder()
                .setHeaderParam(Header.JWT_TYPE, Header.JWT_TYPE)
                .setClaims(claims)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + expire))
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();
    }
}
