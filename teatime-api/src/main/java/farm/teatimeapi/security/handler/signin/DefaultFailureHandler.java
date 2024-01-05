package farm.teatimeapi.security.handler.signin;


import com.google.gson.Gson;
import farm.teatimecore.dto.ExceptionDto;
import farm.teatimecore.exception.ErrorCode;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Component
public class DefaultFailureHandler implements AuthenticationFailureHandler {
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(ErrorCode.FAILURE_LOGIN.getStatus().value());

        Map<String, Object> res = new HashMap<>();
        res.put("success", false);
        res.put("data", null);
        res.put("error", ExceptionDto.of(ErrorCode.FAILURE_LOGIN));

        Gson gson = new Gson();
        response.getWriter().write(gson.toJson(res));
    }
}
