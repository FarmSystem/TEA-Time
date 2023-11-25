package com.farm.api.config;

import com.farm.api.constant.Constant;
import com.farm.api.utils.SocialIdArgumentResolver;
import com.farm.api.utils.SocialIdInterceptor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.List;

@Configuration
@RequiredArgsConstructor
public class WebMvcConfig implements WebMvcConfigurer {
    private final SocialIdArgumentResolver socialIdArgumentResolver;

    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
        WebMvcConfigurer.super.addArgumentResolvers(resolvers);
        resolvers.add(socialIdArgumentResolver);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new SocialIdInterceptor())
                .addPathPatterns("/api/v1/**")
                .excludePathPatterns(Constant.AUTH_WHITELIST);
    }
}
