import 'package:get/get.dart';
import 'package:tea_time/viewModel/analysis/analysis_view_model.dart';

class AnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnalysisViewModel());
  }
}