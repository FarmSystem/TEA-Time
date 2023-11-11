package com.farm.api.exception;

import com.farm.api.dto.exception.ResponseDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(value = {CustomException.class})
    public ResponseEntity<? extends Object> handleCustomException(CustomException e) {
        log.error("handleCustomException", e);
        return ResponseDto.toResponseEntity(e);
    }

    @ExceptionHandler(value = {Exception.class})
    public ResponseEntity<? extends Object> handleException(Exception e) {
        log.error("handleException", e);
        return ResponseDto.toResponseEntity(e);
    }
}
