package com.farm.api.utils;

import com.farm.api.annotation.SocialId;
import com.farm.api.exception.CustomException;
import com.farm.api.exception.ErrorCode;
import jakarta.validation.constraints.NotNull;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

@Component
public class SocialIdArgumentResolver implements HandlerMethodArgumentResolver {
    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return parameter.getParameterType().equals(String.class)
                && parameter.hasParameterAnnotation(SocialId.class);
    }

    @Override
    public Object resolveArgument(@NotNull MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        final Object socialIdObj = webRequest.getAttribute("socialId", WebRequest.SCOPE_REQUEST);
        if (socialIdObj == null) {
            throw new CustomException(ErrorCode.ACCESS_DENIED_ERROR);
        }

        return socialIdObj.toString();
    }
}
