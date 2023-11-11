package com.farm.api.dto.exception;

import com.farm.api.exception.CustomException;
import jakarta.annotation.Nullable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

@Getter
@Builder
@AllArgsConstructor
public class ResponseDto<T> {
    private final Boolean success;
    private final T data;
    private ExceptionDto error;

    public ResponseDto(@Nullable T data) {
        this.success = true;
        this.data = data;
    }

    /**
     * @return Custom Exception
     */
    public static ResponseEntity<Object> toResponseEntity(CustomException e) {
        return ResponseEntity.status(e.getErrorCode().getHttpstatus())
                .body(ResponseDto.builder()
                        .success(false)
                        .data(null)
                        .error(new ExceptionDto(e.getErrorCode())).build());
    }

    /**
     * @return Exception
     */
    public static ResponseEntity<Object> toResponseEntity(Exception e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(ResponseDto.builder()
                        .success(false)
                        .data(null)
                        .error(new ExceptionDto(e)).build());
    }
}
