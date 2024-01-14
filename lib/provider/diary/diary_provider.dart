import 'package:dio/dio.dart';
import 'package:tea_time/provider/base/http_util.dart';
import 'package:tea_time/util/function/log_on_dev.dart';

class DiaryProvider {
  static final Dio authDio = HttpUtil().authDio;

  Future createDiary(
      String title,
      String content,
      MultipartFile image
      ) async {

    final formData = FormData.fromMap({
      "data": {
        "title": title,
        "content": content,
      },
      "image": image,
    });

    try {
      final response = await authDio.post("/diaries", data: formData, options: Options(contentType: "multipart/form-data"));

      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        return throw Exception(
            "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}");
      }
    } on Exception catch (e) {
      return Future.error(e);
    }
  }


  Future<Map<String, dynamic>> getDiaries() async {
    try {
      final response = await authDio.get(
          "/calendar"
      );

      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        return throw Exception(
            "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}"
        );
      }
    } on Exception catch (e) {
      logOnDev("오류 발생: $e");
      rethrow;
    }
  }

  Future getDiaryDetail(int diaryId) async {
    try {
      final response = await authDio.get("/diaries/$diaryId");

      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        return throw Exception(
            "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}");
      }
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  Future updateDiary(int diaryId) async {
    try {
      final response = await authDio.get("/diaries/$diaryId");

      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        return throw Exception(
            "API 요청이 실패했습니다. - ${response.data["error"]["code"]} ${response.data["error"]["message"]}");
      }
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}