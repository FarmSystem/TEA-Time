package farm.teatimecore.contrant;

import java.util.List;

public class Constants {
    public static String USER_ID_CLAIM_NAME = "uid";
    public static String USER_ROLE_CLAIM_NAME = "rol";
    public static String BEARER_PREFIX = "Bearer ";
    public static String AUTHORIZATION_HEADER = "Authorization";
    public static List<String> NO_NEED_AUTH_URLS = List.of(
            "/api/auth/sign-in",
            "/api/auth/sign-up",
            "/api-docs.html",
            "/api-docs/**",
            "/swagger-ui/**"
    );
}
