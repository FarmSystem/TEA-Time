import 'package:dio/dio.dart';
import 'package:tea_time/provider/base/http_util.dart';
import 'package:tea_time/util/function/log_on_dev.dart';

class UserInfoProvider {
  static final Dio authDio = HttpUtil().authDio;

  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      final response = await authDio.get(
        "/me"
      );

      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        return throw Exception(
          "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}"
        );
      }
    } on Exception catch (e) {
      logOnDev("[User Info Provider Error] $e");
      rethrow;
    }
  }
}