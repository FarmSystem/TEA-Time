package com.farm.api.constant;

public class Constant {
    public static final String[] AUTH_WHITELIST = {
            "/api-docs",
            "/swagger-ui/index.html",
            "/v3/api-docs/**",
            "/api/v1/auth/kakao",
            "/api/v1/auth/kakao/callback",
            "/api/v1/auth/google",
            "/api/v1/auth/google/callback",
            "/api/v1/auth/refresh",
            "/api/v1/health"
    };
}
