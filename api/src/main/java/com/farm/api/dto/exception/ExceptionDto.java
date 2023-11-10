package com.farm.api.dto.exception;

import com.farm.api.exception.ErrorCode;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class ExceptionDto {
    private final String code;
    private final String message;

    /**
     * Custom Exception에 대한 dto
     */
    public ExceptionDto(ErrorCode errorCode) {
        this.code = errorCode.getCode();
        this.message = errorCode.getMessage();
    }

    /**
     * 일반 Exception에 대한 dto
     */
    public ExceptionDto(Exception e) {
        this.code = ErrorCode.INTER_SEVER_ERROR.getCode();
        this.message = e.getMessage();
    }
}
