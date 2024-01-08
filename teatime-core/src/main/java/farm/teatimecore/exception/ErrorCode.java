package farm.teatimecore.exception;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public enum ErrorCode {
    /**
     * 400 Bad Request
     */
    BAD_REQUEST_ERROR(400, HttpStatus.BAD_REQUEST, "잘못된 요청입니다."),
    INVALID_PARAMETER_ERROR(400, HttpStatus.BAD_REQUEST, "요휴하지 않은 파라미터입니다."),
    MISSING_REQUEST_PARAMETER_ERROR(400, HttpStatus.BAD_REQUEST, "필수 요청 파라미터가 누락되었습니다."),
    INVALID_HEADER_ERROR(400, HttpStatus.BAD_REQUEST, "유효하지 않은 헤더입니다."),
    MISSING_REQUEST_HEADER_ERROR(400, HttpStatus.BAD_REQUEST, "필수 요청 헤더가 누락되었습니다."),
    DUPLICATED_NICKNAME_ERROR(400, HttpStatus.BAD_REQUEST, "중복된 닉네임입니다."),
    DUPLICATED_EMAIL_ERROR(400, HttpStatus.BAD_REQUEST, "중복된 이메일입니다."),
    USER_NOT_MATCH(400, HttpStatus.BAD_REQUEST, "사용자가 작성자와 일치하지 않습니다."),

    /**
     * 401 Unauthorized
     */
    UNAUTHORIZED_ERROR(401, HttpStatus.UNAUTHORIZED, "인증되지 않은 사용자입니다."),
    FAILURE_LOGIN(401, HttpStatus.UNAUTHORIZED, "로그인에 실패했습니다."),
    TOKEN_MALFORMED_ERROR(401, HttpStatus.UNAUTHORIZED, "토큰이 올바르지 않습니다."),
    TOKEN_TYPE_ERROR(401, HttpStatus.UNAUTHORIZED, "토큰 타입이 일치하지 않거나 비어있습니다."),
    EXPIRED_TOKEN_ERROR(401, HttpStatus.UNAUTHORIZED, "만료된 토큰입니다."),
    TOKEN_UNSUPPORTED_ERROR(401, HttpStatus.UNAUTHORIZED, "지원하지않는 토큰입니다."),
    TOKEN_UNKNOWN_ERROR(401, HttpStatus.UNAUTHORIZED, "알 수 없는 토큰입니다."),

    /**
     * 403 Forbidden
     */
    FORBIDDEN_ERROR(403, HttpStatus.FORBIDDEN, "접근 권한이 없습니다."),
    ACCESS_DENIED(403, HttpStatus.FORBIDDEN, "접근 권한이 없습니다."),

    /**
     * 404 Not Found
     */
    NOT_FOUND_ERROR(404, HttpStatus.NOT_FOUND, "요청하신 리소스를 찾을 수 없습니다."),
    NOT_FOUND_END_POINT(404, HttpStatus.NOT_FOUND, "존재하지 않는 API 엔드포인트입니다."),
    NOT_FOUND_LOGIN_USER(404, HttpStatus.NOT_FOUND, "로그인한 사용자가 존재하지 않습니다."),
    NOT_FOUND_USER(404, HttpStatus.NOT_FOUND, "사용자가 존재하지 않습니다."),
    NOT_FOUND_DIARY(404, HttpStatus.NOT_FOUND, "다이어리가 존재하지 않습니다."),

    /**
     * 405 Method Not Allowed
     */
    NOT_ALLOWED_METHOD_ERROR(405, HttpStatus.METHOD_NOT_ALLOWED, "허용되지 않은 메소드입니다."),

    /**
     * 500 Internal Server Error
     */
    INTERNAL_SERVER_ERROR(500, HttpStatus.INTERNAL_SERVER_ERROR, "서버에 오류가 발생하였습니다."),
    FILE_DELETE_ERROR(500, HttpStatus.INTERNAL_SERVER_ERROR, "파일 삭제에 실패하였습니다."),
    FILE_UPLOAD_ERROR(500, HttpStatus.INTERNAL_SERVER_ERROR, "파일 업로드에 실패하였습니다.");

    private final Integer code;
    private final HttpStatus status;
    private final String message;
}
