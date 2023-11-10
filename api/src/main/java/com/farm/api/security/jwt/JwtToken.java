package com.farm.api.security.jwt;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;

@Data
@Builder
@Getter
public class JwtToken {
    private String accessToken;
    private String refreshToken;
}
