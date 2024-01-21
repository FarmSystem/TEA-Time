import 'dart:math';

import 'package:dio/dio.dart';
import 'package:tea_time/model/analysis/diary_analysis_model.dart';
import 'package:tea_time/provider/base/http_util.dart';

class AnalysisProvider {
  static final Dio authDio = HttpUtil().authDio;

  Future getMonthlyAnalysis() async {
    try {
      final response = await authDio.get("/analysis/monthly");

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

  Future getWeeklyAnalysis() async {
    try {
      final response = await authDio.get("/analysis/weekly");

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

  Future<Map<String, dynamic>> getDiaryAnalysis(int diaryId) async {
    try {
      final response = await authDio.get("/analysis/$diaryId");

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

  Future<List<dynamic>> readEmotionAnalysisData(int period) async {
    List<dynamic> data = [];

    try {
      final response = await authDio.get("/analysis/chart?period=$period");

      if (response.statusCode == 200) {
        for (int i = 0; i < period; i++) {
          data.add({
            "score": response.data["data"][i]["score"],
          });
        }
        return data;
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