import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:tea_time/model/types/time_period.dart';
import 'package:tea_time/repository/analysis/analysis_repository.dart';

class AnalysisViewModel extends GetxController {
  late final AnalysisRepository _repository;

  late final DateTime _currentDate;
  late final Rx<bool> _isLoading;
  late final RxList<FlSpot> _weekEmotionScore;
  late final RxList<FlSpot> _monthEmotionScore;

  bool get isLoading => _isLoading.value;
  List<FlSpot> get weekEmotionScore => _weekEmotionScore;
  List<FlSpot> get monthEmotionScore => _monthEmotionScore;

  @override
  void onInit() async {
    super.onInit();
    // Dependency Injection
    _repository = Get.find<AnalysisRepository>();

    // Init
    _currentDate = DateTime.now();

    _isLoading = true.obs;
    _weekEmotionScore = (await _repository.fetchEmotionAnalysisData(
        TimePeriod.seven, _currentDate))
        .obs;
    _monthEmotionScore = (await _repository.fetchEmotionAnalysisData(
        TimePeriod.thirty, _currentDate))
        .obs;
    _isLoading.value = false;
  }
}
