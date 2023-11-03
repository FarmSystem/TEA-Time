package com.farm.api.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.AntPathMatcher;

@Configuration
public class WebConfig {
    @Bean
    public AntPathMatcher antPathMatcher() {
        return new AntPathMatcher();
    }
}

