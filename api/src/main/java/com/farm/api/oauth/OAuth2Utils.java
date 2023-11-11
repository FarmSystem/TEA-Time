package com.farm.api.oauth;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;


@Slf4j
@Component
@RequiredArgsConstructor
public class OAuth2Utils {
    /**
     * Kakao OAuth2
     */

    @Value("${security.oauth2.kakao.authentication_url}")
    private String KAKAO_AUTHENTICATION_URL;
    @Value("${security.oauth2.kakao.token_url}")
    private String KAKAO_TOKEN_URL;
    @Value("${security.oauth2.kakao.user_info_url}")
    private String KAKAO_USER_INFO_URL;
    @Value("${security.oauth2.kakao.client_id}")
    private String KAKAO_CLIENT_ID;
    @Value("${security.oauth2.kakao.client_secret}")
    private String KAKAO_CLIENT_SECRET;
    @Value("${security.oauth2.kakao.redirect_url}")
    private String KAKAO_REDIRECT_URL;

    /**
     * Google OAuth2
     */
    @Value("${security.oauth2.google.authentication_url}")
    private String GOOGLE_AUTHENTICATION_URL;
    @Value("${security.oauth2.google.token_url}")
    private String GOOGLE_TOKEN_URL;
    @Value("${security.oauth2.google.user_info_url}")
    private String GOOGLE_USER_INFO_URL;
    @Value("${security.oauth2.google.client_id}")
    private String GOOGLE_CLIENT_ID;
    @Value("${security.oauth2.google.client_secret}")
    private String GOOGLE_CLIENT_SECRET;
    @Value("${security.oauth2.google.redirect_url}")
    private String GOOGLE_REDIRECT_URL;

    private static final RestTemplate restTemplate = new RestTemplate();

    /**
     * OAuth2 Redirect URL
     * @return redirect url
     */
    public String getKakaoRedirectUrl() {
        return KAKAO_AUTHENTICATION_URL
                + "?client_id=" + KAKAO_CLIENT_ID
                + "&redirect_uri=" + KAKAO_REDIRECT_URL
                + "&response_type=code";
    }

    public String getGoogleRedirectUrl() {
        return GOOGLE_AUTHENTICATION_URL
                + "?client_id=" + GOOGLE_CLIENT_ID
                + "&redirect_uri=" + GOOGLE_REDIRECT_URL
                + "&response_type=code&scope=https://www.googleapis.com/auth/userinfo.profile";
    }

    /**
     * OAuth2 Access Token
     * @return access token
     */
    public String getKakaoAccessToken(String authorizationCode) {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        MultiValueMap<String, String> params = new org.springframework.util.LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", KAKAO_CLIENT_ID);
        params.add("client_secret", KAKAO_CLIENT_SECRET);
        params.add("redirect_uri", KAKAO_REDIRECT_URL);
        params.add("code", authorizationCode);

        HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, httpHeaders);

        ResponseEntity<String> response = restTemplate.exchange(
                KAKAO_TOKEN_URL,
                HttpMethod.POST,
                kakaoTokenRequest,
                String.class
        );

        return JsonParser.parseString(response.getBody()).getAsJsonObject().get("access_token").getAsString();
    }

    public String getGoogleAccessToken(String authorizationCode) {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        MultiValueMap<String, String> params = new org.springframework.util.LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", GOOGLE_CLIENT_ID);
        params.add("client_secret", GOOGLE_CLIENT_SECRET);
        params.add("redirect_uri", GOOGLE_REDIRECT_URL);
        params.add("code", authorizationCode);

        HttpEntity<MultiValueMap<String, String>> googleTokenRequest = new HttpEntity<>(params, httpHeaders);

        ResponseEntity<String> response = restTemplate.exchange(
                GOOGLE_TOKEN_URL,
                HttpMethod.POST,
                googleTokenRequest,
                String.class
        );

        return JsonParser.parseString(response.getBody()).getAsJsonObject().get("access_token").getAsString();
    }

    /**
     * OAuth2 User Info
     * @return user info
     */
    public String getKakaoUserInfo(String accessToken) {
        HttpHeaders httpHeaders = new HttpHeaders();

        httpHeaders.add("Authorization", "Bearer " + accessToken);
        httpHeaders.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        HttpEntity<MultiValueMap<String, String>> kakaoUserInfoRequest = new HttpEntity<>(httpHeaders);

        ResponseEntity<String> response = restTemplate.exchange(
                KAKAO_USER_INFO_URL,
                HttpMethod.POST,
                kakaoUserInfoRequest,
                String.class
        );

        JsonElement element = JsonParser.parseString(response.getBody());
        return element.getAsJsonObject().get("id").getAsString();
    }

    public String getGoogleUserInfo(String accessToken) {
        HttpHeaders httpHeaders = new HttpHeaders();

        httpHeaders.add("Authorization", "Bearer " + accessToken);
        httpHeaders.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        HttpEntity<MultiValueMap<String, String>> googleUserInfoRequest = new HttpEntity<>(httpHeaders);

        ResponseEntity<String> response = restTemplate.exchange(
                GOOGLE_USER_INFO_URL,
                HttpMethod.POST,
                googleUserInfoRequest,
                String.class
        );

        JsonElement element = JsonParser.parseString(response.getBody());
        return element.getAsJsonObject().get("sub").getAsString();
    }

}
