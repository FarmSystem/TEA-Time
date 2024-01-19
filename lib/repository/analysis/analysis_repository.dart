import 'package:get/get.dart';
import 'package:tea_time/model/analysis/diary_analysis_model.dart';
import 'package:tea_time/provider/analysis/analysis_provider.dart';
import 'package:tea_time/util/function/log_on_dev.dart';

class AnalysisRepository extends GetxService {
  late final AnalysisProvider _analysisProvider;

  @override
  void onInit() {
    super.onInit();

    // Dependency Injection
    _analysisProvider = Get.put(AnalysisProvider());
  }

  Future<DiaryAnalysisModel> getDiaryAnalysis(int diaryId) async {
    try {
      Map<String, dynamic> response = await _analysisProvider.getDiaryAnalysis(diaryId);
      logOnDev(response.toString());
      return DiaryAnalysisModel.fromJson(response);
    } on Exception catch(e) {
      return Future.error(e);
    }
  }
}