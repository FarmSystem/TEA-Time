package com.farm.api.security;

import com.farm.api.dto.exception.ExceptionDto;
import com.farm.api.exception.ErrorCode;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Component
public class JwtAccessDeniedHandler implements AccessDeniedHandler {
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
        /**
         * 403 Forbidden return
         */
        setErrorResponse(response, ErrorCode.ACCESS_DENIED_ERROR);
    }

    public void setErrorResponse(HttpServletResponse response, ErrorCode errorCode) throws IOException {
        response.setContentType("application/json");
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        Map<String, Object> map = new HashMap<>();
        map.put("success", Boolean.FALSE);
        map.put("data", null);
        map.put("error", new ExceptionDto(errorCode));

        Gson gson = new Gson();
        String jsonString = gson.toJson(map);
        response.getWriter().print(jsonString);
    }
}
