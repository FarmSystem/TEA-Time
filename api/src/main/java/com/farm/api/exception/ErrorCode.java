package com.farm.api.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {
    /**
     * 400: Bad Request
     */
    BAD_REQUEST_ERROR("4000", HttpStatus.BAD_REQUEST, "Bad Request"),

    /**
     * 401: Access is Denied
     */
    UNAUTHORIZED_ERROR("4010", HttpStatus.UNAUTHORIZED, "Unauthorized"),
    INVALID_TOKEN_ERROR("4011", HttpStatus.UNAUTHORIZED, "Invalid Token"),
    MALFORMED_TOKEN_ERROR("4012", HttpStatus.UNAUTHORIZED, "Malformed Token"),
    UNKNOWN_TOKEN_ERROR("4013", HttpStatus.UNAUTHORIZED, "Unknown Token"),
    EXPIRED_TOKEN_ERROR("4014", HttpStatus.UNAUTHORIZED, "Expired Token"),
    TOKEN_TYPE_ERROR("4015", HttpStatus.UNAUTHORIZED, "Token Type Error"),
    UNSUPPORTED_TOKEN_ERROR("4016", HttpStatus.UNAUTHORIZED, "Unsupported Token"),

    /**
     * 403: Forbidden
     */
    FORBIDDEN_ERROR("4030", HttpStatus.FORBIDDEN, "Forbidden"),
    ACCESS_DENIED_ERROR("4031", HttpStatus.FORBIDDEN, "Access is Denied"),

    /**
     * 404: Not Found
     */
    NOT_FOUND_USER("4040", HttpStatus.NOT_FOUND, "Not Found User"),
    NOT_FOUND_DIARY("4041", HttpStatus.NOT_FOUND, "Not Found Diary"),
    NOT_FOUND_REACTION_TYPE("4042", HttpStatus.NOT_FOUND, "Not Found Reaction Type"),

    /**
     * 500: Internal Server Error
     */
    INTER_SEVER_ERROR("5000", HttpStatus.INTERNAL_SERVER_ERROR, "Internal Server Error");

    private final String code;
    private final HttpStatus httpstatus;
    private final String message;
}
