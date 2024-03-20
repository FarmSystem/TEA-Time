package farm.teatimecore.dto;

import farm.teatimecore.exception.ErrorCode;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;

@Getter
public class ExceptionDto {
    @NotNull
    @Schema(name = "code", description = "에러 코드")
    private final Integer code;

    @NotNull
    @Schema(name = "message", description = "에러 메시지")
    private final String message;

    public ExceptionDto(ErrorCode errorCode) {
        this.code = errorCode.getCode();
        this.message = errorCode.getMessage();
    }

    public ExceptionDto(Exception e) {
        this.code = ErrorCode.INTERNAL_SERVER_ERROR.getCode();
        this.message = e.getMessage();
    }

    public static ExceptionDto of(ErrorCode errorCode) {
        return new ExceptionDto(errorCode);
    }
}
