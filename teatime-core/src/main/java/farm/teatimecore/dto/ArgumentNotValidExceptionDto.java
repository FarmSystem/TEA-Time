package farm.teatimecore.dto;

import farm.teatimecore.exception.ErrorCode;
import jakarta.validation.ConstraintViolationException;
import lombok.Getter;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;

import java.util.HashMap;
import java.util.Map;

@Getter
public class ArgumentNotValidExceptionDto extends ExceptionDto {
    public final Map<String, String> errors;

    public ArgumentNotValidExceptionDto(final MethodArgumentNotValidException methodArgumentNotValidException) {
        super(ErrorCode.INVALID_PARAMETER_ERROR);
        this.errors = new HashMap<>();
        methodArgumentNotValidException.getBindingResult()
                .getAllErrors().forEach(e -> this.errors.put(((FieldError) e).getField(), e.getDefaultMessage()));
    }

    public ArgumentNotValidExceptionDto(final ConstraintViolationException exception) {
        super(ErrorCode.INVALID_PARAMETER_ERROR);
        this.errors = new HashMap<>();
        for (var violation : exception.getConstraintViolations()) {
            this.errors.put(violation.getPropertyPath().toString(), violation.getMessage());
        }
    }
}
