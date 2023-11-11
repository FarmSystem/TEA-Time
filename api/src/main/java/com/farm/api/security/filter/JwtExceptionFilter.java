package com.farm.api.security.filter;

import com.farm.api.constant.Constant;
import com.farm.api.exception.ErrorCode;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.UnsupportedJwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Arrays;

@Slf4j
@RequiredArgsConstructor
public class JwtExceptionFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");

        boolean isException = false;

        try {
            filterChain.doFilter(request, response);
        }
        catch (SecurityException e) {
            log.error("SecurityException: {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.ACCESS_DENIED_ERROR);
            isException = true;
        } catch (MalformedJwtException e) {
            log.error("MalformedJwtException: {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.INVALID_TOKEN_ERROR);
            isException = true;
        } catch (IllegalArgumentException e) {
            log.error("Exception: {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.TOKEN_TYPE_ERROR);
            isException = true;
        } catch (ExpiredJwtException e) {
            log.error("ExpiredJwtException: {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.EXPIRED_TOKEN_ERROR);
            isException = true;
        } catch (UnsupportedJwtException e) {
            log.error("UnsupportedJwtException: {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.UNSUPPORTED_TOKEN_ERROR);
            isException = true;
        } catch (JwtException e) {
            log.error("JwtException: {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.UNKNOWN_TOKEN_ERROR);
            isException = true;
        } catch (Exception e) {
            log.error("Exception: {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.NOT_FOUND_USER);
            isException = true;
        }

        if (isException) {
            filterChain.doFilter(request, response);
        }
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
        return Arrays.stream(Constant.AUTH_WHITELIST).anyMatch(url -> url.equals(request.getServletPath()));
    }
}
