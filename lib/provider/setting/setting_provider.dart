import 'package:dio/dio.dart';
import 'package:tea_time/model/setting/user_level.dart';
import 'package:tea_time/provider/base/http_util.dart';

class SettingProvider {
  static final Dio authDio = HttpUtil().authDio;

  Future<UserLevel> getUserLevel() async {
    try {
      final response = await authDio.get(
          "/me/level"
      );

      if (response.statusCode == 200) {
        return UserLevel.fromJson(response.data["data"]);
      } else {
        return throw Exception(
            "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}"
        );
      }
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}