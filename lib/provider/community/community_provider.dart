import 'package:dio/dio.dart';
import 'package:tea_time/provider/base/http_util.dart';

class CommunityProvider {
  static final Dio authDio = HttpUtil().authDio;

  Future getCommunity(int page, int size) async {
    try {
      final response = await authDio.get("/community?page=$page&size=$size");

      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        return throw Exception(
            "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}"
        );
      }
    } on Exception catch(e) {
      return Future.error(e);
    }
  }

  Future getMember() async {
    try {
      final response = await authDio.get("/community/member");

      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        return throw Exception(
            "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}"
        );
      }
    } on Exception catch(e) {
      return Future.error(e);
    }
  }

  Future postMember(
      String nickname
      ) async {
    try {
      final response = await authDio.post("/community/member?nickname=$nickname");

      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        return throw Exception(
            "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}"
        );
      }
    } on Exception catch(e) {
      return Future.error(e);
    }
  }

  Future getMemberProfile(
      int memberId, int page, int size
      ) async {
    try {
      final response = await authDio.get("/community/member/$memberId");

      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        return throw Exception(
            "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}"
        );
      }
    } on Exception catch(e) {
      return Future.error(e);
    }
  }
}