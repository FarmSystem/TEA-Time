package farm.teatimeapi.security.handler.jwt;

import farm.teatimeapi.security.info.AbstractAuthenticationFailure;
import farm.teatimecore.exception.ErrorCode;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class JwtAccessDeniedHandler extends AbstractAuthenticationFailure implements AccessDeniedHandler {
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException {
        setErrorResponse(response, ErrorCode.ACCESS_DENIED);
    }
}
