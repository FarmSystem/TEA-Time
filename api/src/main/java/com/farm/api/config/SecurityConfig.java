package com.farm.api.config;

import com.farm.api.constant.Constant;
import com.farm.api.security.CustomUserDetailsService;
import com.farm.api.security.JwtAccessDeniedHandler;
import com.farm.api.security.JwtEntryPoint;
import com.farm.api.security.filter.JwtAuthenticationFilter;
import com.farm.api.security.filter.JwtExceptionFilter;
import com.farm.api.security.jwt.JwtProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;


@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final JwtProvider jwtProvider;
    private final CustomUserDetailsService customUserDetailsService;
    private final JwtEntryPoint jwtEntryPoint;
    private final JwtAccessDeniedHandler jwtAccessDeniedHandler;

    @Bean
    protected SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
                .httpBasic(AbstractHttpConfigurer::disable)
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement((sessionManagement) ->
                        sessionManagement.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(config -> config
                        .requestMatchers(Constant.AUTH_WHITELIST).permitAll()
                        // Security 설정 오류로 인해 API 테스트 시 임시로 모든 요청에 대한 접근을 허용
                        .requestMatchers("*").permitAll()
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().authenticated()
                )
                .exceptionHandling((exceptionHandling) ->
                        exceptionHandling
                                .authenticationEntryPoint(jwtEntryPoint)
                                .accessDeniedHandler(jwtAccessDeniedHandler)
                )
                .addFilterBefore(new JwtAuthenticationFilter(
                        jwtProvider, customUserDetailsService), UsernamePasswordAuthenticationFilter.class
                )
                .addFilterBefore(new JwtExceptionFilter(), JwtAuthenticationFilter.class);
        return httpSecurity.build();
    }
}
