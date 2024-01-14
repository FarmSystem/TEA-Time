import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tea_time/provider/Base/http_util.dart';
import 'package:tea_time/util/enum/secure_token_key.dart';
import 'package:tea_time/util/function/log_on_dev.dart';

class AuthProvider {
  static final Dio dio = HttpUtil().dio;
  static final Dio authDio = HttpUtil().authDio;

  Future<bool> signIn(String email, String password) async {
    final formData = FormData.fromMap({
      "email": email,
      "password": password,
    });

    try {
      final response = await dio.post("/auth/sign-in", data: formData);

      final accessToken = response.data["data"][AuthToken.accessToken.jsonKey];
      final refreshToken = response.data["data"][AuthToken.refreshToken.jsonKey];

      // 기존 Token 삭제
      const secureStorage = FlutterSecureStorage();
      await secureStorage.deleteAll();

      // Access Token 저장
      await secureStorage.write(
        key: AuthToken.accessToken.key,
        value: accessToken,
      );

      // Refresh Token 저장
      await secureStorage.write(
        key: AuthToken.refreshToken.key,
        value: refreshToken,
      );

      logOnDev("[Sign-in Success] New Token Set");
      logOnDev("Access Token : $accessToken");
      logOnDev("Refresh Token : $refreshToken");

      return true;
    } on DioException catch (_) {
      return false;
    } on PlatformException catch (error) {
      logOnDev("[Flutter Secure Storage Error] Message : ${error.message}");
      return false;
    }
  }

  Future<bool> signUp(
      String email,
      String password,
      String nickname,
      ) async {
    final requestBody = <String, dynamic> {
      "email": email,
      "password": password,
      "nickname": nickname,
    };

    try {
      await dio.post("/auth/sign-up", data: requestBody);
      return true;
    } on DioException catch (_) {
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await authDio.post("/auth/sign-out");
      const secureStorage = FlutterSecureStorage();
      await secureStorage.deleteAll();
      return true;
    } on DioException catch (_) {
      return false;
    } on PlatformException catch (error) {
      logOnDev("[Flutter Secure Storage Error] Message : ${error.message}");
      return false;
    }
  }

  Future<bool> refresh(String refreshToken) async {
    try {
      final response = await dio.post("/auth/reissue",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer $refreshToken',
          }));

      final newAccessToken = response.data["data"][AuthToken.accessToken.jsonKey];
      final newRefreshToken = response.data["data"][AuthToken.refreshToken.jsonKey];

      const secureStorage = FlutterSecureStorage();
      await secureStorage.write(
        key: AuthToken.accessToken.key,
        value: newAccessToken,
      );
      await secureStorage.write(
        key: AuthToken.refreshToken.key,
        value: newRefreshToken,
      );

      return true;
    } on DioException catch (_) {
      return false;
    }
  }
}