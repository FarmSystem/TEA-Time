package farm.teatimeapi.interceptor.pre;

import farm.teatimecore.contrant.Constants;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;

public class UserIdInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        request.setAttribute(Constants.USER_ID_INTERCEPTOR, authentication.getName());
        return HandlerInterceptor.super.preHandle(request, response, handler);
    }
}
