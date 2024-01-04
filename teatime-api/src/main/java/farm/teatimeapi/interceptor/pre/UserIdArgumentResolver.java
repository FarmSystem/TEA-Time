package farm.teatimeapi.interceptor.pre;

import farm.teatimecore.annotation.UserId;
import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

@Component
public class UserIdArgumentResolver implements HandlerMethodArgumentResolver {
    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return parameter.getParameter().getType().equals(Long.class)
                && parameter.hasParameterAnnotation(UserId.class);
    }

    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        final Object userIdObj = webRequest.getAttribute("USER_ID", NativeWebRequest.SCOPE_REQUEST);

        if (userIdObj == null) {
            throw new CustomException(ErrorCode.INVALID_HEADER_ERROR);
        }
        return Long.valueOf(userIdObj.toString());
    }
}
