import 'package:dio/dio.dart';
import 'package:tea_time/model/home/user_nickname_model.dart';
import 'package:tea_time/provider/Base/http_util.dart';

class HomeProvider {
  static final Dio authDio = HttpUtil().authDio;

  Future<UserNicknameModel> getUserNickname() async {
    try {
      final response = await authDio.get(
        "/api/me/nickname"
      );

      if (response.statusCode == 200) {
        return UserNicknameModel.fromJson(response.data["data"]);
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