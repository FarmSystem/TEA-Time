import 'package:get/get.dart';
import 'package:tea_time/model/diary/diary_detail_model.dart';
import 'package:tea_time/provider/diary/diary_provider.dart';
import 'package:tea_time/util/function/log_on_dev.dart';

class DiaryDetailRepository extends GetxService {
  late final DiaryProvider _diaryProvider;

  @override
  void onInit() {
    super.onInit();

    // Dependency Injection
    _diaryProvider = Get.find<DiaryProvider>();
  }

  Future<DiaryDetailModel> getDiaryDetail(int id) async {
    Map<String, dynamic> response = await _diaryProvider.getDiaryDetail(id);
    logOnDev("📝 [Diary Detail] $response");
    return DiaryDetailModel.fromJson(response);
  }
}