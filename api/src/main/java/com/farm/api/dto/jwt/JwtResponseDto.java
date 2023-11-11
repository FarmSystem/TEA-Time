package com.farm.api.dto.jwt;

import com.farm.api.security.jwt.JwtToken;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class JwtResponseDto {
    private JwtToken jwtToken;
}
