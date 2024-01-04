package farm.teatimecore.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import io.micrometer.common.lang.Nullable;
import jakarta.validation.ConstraintViolationException;
import jakarta.validation.constraints.NotNull;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;

public record ResponseDto<T>(
        @JsonIgnore HttpStatus httpStatus,
        @NotNull Boolean success,
        @Nullable T data,
        @Nullable ExceptionDto error
        ) {
    public static <T> ResponseDto<T> ok(@Nullable final T data) {
        return new ResponseDto<>(HttpStatus.OK, true, data, null);
    }

    public static <T> ResponseDto<T> created(@Nullable final T data) {
        return new ResponseDto<>(HttpStatus.CREATED, true, data, null);
    }

    public static ResponseDto<Object> fail(final MethodArgumentNotValidException e) {
        return new ResponseDto<>(HttpStatus.BAD_REQUEST, false, null, new ArgumentNotValidExceptionDto(e));
    }

    public static ResponseDto<Object> fail(final ConstraintViolationException e) {
        return new ResponseDto<>(HttpStatus.BAD_REQUEST, false, null, new ArgumentNotValidExceptionDto(e));
    }

    public static ResponseDto<Object> fail(final MissingServletRequestParameterException e) {
        return new ResponseDto<>(HttpStatus.BAD_REQUEST, false, null, ExceptionDto.of(ErrorCode.MISSING_REQUEST_PARAMETER_ERROR));
    }

    public static ResponseDto<Object> fail(final CustomException e) {
        return new ResponseDto<>(e.getErrorCode().getStatus(), false, null, ExceptionDto.of(e.getErrorCode()));
    }
}
