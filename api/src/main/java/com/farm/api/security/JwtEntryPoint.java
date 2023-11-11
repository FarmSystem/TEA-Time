package com.farm.api.security;

import com.farm.api.dto.exception.ExceptionDto;
import com.farm.api.exception.ErrorCode;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Component
public class JwtEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
        ErrorCode errorCode = (ErrorCode) request.getAttribute("exception");

        if (errorCode == null) {
            setErrorResponse(response, ErrorCode.ACCESS_DENIED_ERROR);
        } else {
            switch (errorCode) {
                case UNAUTHORIZED_ERROR -> { setErrorResponse(response, ErrorCode.UNAUTHORIZED_ERROR); }
                case FORBIDDEN_ERROR -> { setErrorResponse(response, ErrorCode.FORBIDDEN_ERROR); }
                case NOT_FOUND_USER -> { setErrorResponse(response, ErrorCode.NOT_FOUND_USER); }
                case INTER_SEVER_ERROR -> { setErrorResponse(response, ErrorCode.INTER_SEVER_ERROR); }
            }
        }
    }

    public void setErrorResponse(HttpServletResponse response, ErrorCode errorCode) throws IOException {
        response.setContentType("application/json");
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

        Map<String, Object> map = new HashMap<>();
        map.put("success", Boolean.FALSE);
        map.put("data", null);
        map.put("error", new ExceptionDto(errorCode));

        Gson gson = new Gson();
        String jsonString = gson.toJson(map);
        response.getWriter().print(jsonString);
    }
}
