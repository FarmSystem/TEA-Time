package farm.teatimeapi.security.info;

import com.google.gson.Gson;
import farm.teatimecore.dto.ExceptionDto;
import farm.teatimecore.exception.ErrorCode;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class AbstractAuthenticationFailure {
    protected void setErrorResponse(
            HttpServletResponse response,
            ErrorCode errorCode
    ) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(errorCode.getStatus().value());

        Map<String, Object> res = new HashMap<>();
        res.put("success", false);
        res.put("data", null);
        res.put("error", ExceptionDto.of(errorCode));

        Gson gson = new Gson();
        response.getWriter().write(gson.toJson(res));
    }
}
