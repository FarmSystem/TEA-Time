import 'package:dio/dio.dart';
import 'package:tea_time/provider/Base/http_util.dart';

class HomeProvider {
  static final Dio authDio = HttpUtil().authDio;

  Future<String> getUserNickname() async {
    try {
      final response = await authDio.get(
        "/me/nickname",
      );

      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        return throw Exception(
          "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}"
        );
      }
    } on Exception catch (e) {
      rethrow;
    }
  }
}