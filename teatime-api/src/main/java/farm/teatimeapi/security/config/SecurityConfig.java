package farm.teatimeapi.security.config;

import farm.teatimeapi.security.filter.GlobalLoggerFilter;
import farm.teatimeapi.security.filter.JwtAuthenticationFilter;
import farm.teatimeapi.security.filter.JwtExceptionFilter;
import farm.teatimeapi.security.handler.jwt.JwtAccessDeniedHandler;
import farm.teatimeapi.security.handler.jwt.JwtAuthenticationEntryPoint;
import farm.teatimeapi.security.handler.signin.DefaultFailureHandler;
import farm.teatimeapi.security.handler.signin.DefaultSuccessHandler;
import farm.teatimeapi.security.handler.signout.CustomSignOutProcessHandler;
import farm.teatimeapi.security.handler.signout.CustomSignOutResultHandler;
import farm.teatimeapi.security.service.CustomUserDetailService;
import farm.teatimeapi.utils.JwtUtil;
import farm.teatimecore.contrant.Constants;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.logout.LogoutFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final DefaultSuccessHandler defaultSuccessHandler;
    private final DefaultFailureHandler defaultFailureHandler;
    private final CustomSignOutResultHandler customSignOutResultHandler;
    private final CustomSignOutProcessHandler customSignOutProcessHandler;
    private final JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;
    private final JwtAccessDeniedHandler jwtAccessDeniedHandler;
    private final CustomUserDetailService customUserDetailService;
    private final JwtUtil jwtUtil;
    @Bean
    protected SecurityFilterChain securityFilterChain(final HttpSecurity httpSecurity) throws Exception {
        return httpSecurity
                .csrf(AbstractHttpConfigurer::disable)
                .httpBasic(AbstractHttpConfigurer::disable)
                .sessionManagement((sessionManagement) ->
                        sessionManagement.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
                .authorizeHttpRequests(registry ->
                        registry
                                .requestMatchers(Constants.NO_NEED_AUTH_URLS.toArray(String[]::new)).permitAll()
                                .requestMatchers(Constants.USER_URLS.toArray(String[]::new)).hasAnyRole("USER")
                                .anyRequest().authenticated())
                .formLogin(configurer -> configurer
                        .loginPage("/login")
                        .loginProcessingUrl("/api/auth/sign-in")
                        .usernameParameter("email")
                        .passwordParameter("password")
                        .successHandler(defaultSuccessHandler)
                        .failureHandler(defaultFailureHandler))
                .logout(configurer -> configurer
                        .logoutUrl("/api/auth/sign-out")
                        .addLogoutHandler(customSignOutProcessHandler)
                        .logoutSuccessHandler(customSignOutResultHandler))
                .exceptionHandling(configurer -> configurer
                        .authenticationEntryPoint(jwtAuthenticationEntryPoint)
                        .accessDeniedHandler(jwtAccessDeniedHandler))
                .addFilterBefore(
                        new JwtAuthenticationFilter(jwtUtil, customUserDetailService),
                        LogoutFilter.class
                )
                .addFilterBefore(
                        new JwtExceptionFilter(),
                        JwtAuthenticationFilter.class
                )
                .addFilterBefore(
                        new GlobalLoggerFilter(),
                        JwtExceptionFilter.class
                )
                .getOrBuild();
    }
}
