import 'package:get/get.dart';
import 'package:tea_time/model/analysis/diary_analysis_model.dart';
import 'package:tea_time/repository/analysis/analysis_repository.dart';
import 'package:tea_time/util/function/log_on_dev.dart';

class AnalysisDiaryViewModel extends GetxController {
  late final Rxn<DiaryAnalysisModel> _diaryAnalysisModel;
  late final AnalysisRepository _analysisRepository;
  RxBool isLoading = false.obs;

  DiaryAnalysisModel? get diaryAnalysisModel => _diaryAnalysisModel.value;

  @override
  void onInit() {
    super.onInit();

    // Dependency Injection
    _analysisRepository = Get.find<AnalysisRepository>();

    // Initialize
    _diaryAnalysisModel = Rxn<DiaryAnalysisModel>();
  }

  Future<void> getDiaryAnalysis(int diaryId) async {
    try {
      isLoading.value = true;
      _diaryAnalysisModel.value = await _analysisRepository.getDiaryAnalysis(diaryId);
    } on Exception catch(e) {
      return Future.error(e);
    } finally {
      isLoading.value = false;
    }
  }
}