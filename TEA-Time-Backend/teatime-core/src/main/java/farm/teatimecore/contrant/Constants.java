package farm.teatimecore.contrant;

import java.util.List;

public class Constants {
    public static String USER_ID_CLAIM_NAME = "uid";
    public static String USER_ID_INTERCEPTOR = "USER_ID";
    public static String USER_ROLE_CLAIM_NAME = "rol";
    public static String BEARER_PREFIX = "Bearer ";
    public static String AUTHORIZATION_HEADER = "Authorization";
    public static List<String> NO_NEED_AUTH_URLS = List.of(
            "/api/auth/sign-in",
            "/api/auth/sign-up",
            "/api/auth/nickname",
            "/api/auth/email",
            "/api-docs.html",
            "/swagger-ui/index.html",
            "/swagger-ui/swagger-ui.css",
            "/swagger-ui/swagger-ui-standalone-preset.js",
            "/swagger-ui/swagger-ui-bundle.js",
            "/swagger-ui/index.css",
            "/swagger-ui/swagger-initializer.js",
            "/v3/api-docs",
            "/v3/api-docs/swagger-config"
    );

    public static List<String> USER_URLS = List.of(
            "/api/**"
            );
}
