import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tea_time/model/diary/diary_small_model.dart';
import 'package:tea_time/model/setting/diary_token_model.dart';
import 'package:tea_time/provider/diary/diary_provider.dart';
import 'package:tea_time/util/function/log_on_dev.dart';

class DiaryCalendarRepository extends GetxService {
  late final DiaryProvider _diaryProvider;

  @override
  onInit() {
    super.onInit();
    // Dependency Injection
    _diaryProvider = Get.find<DiaryProvider>();

    getDiaries();
  }

  Future<Map<String, DiarySmallModel>> getDiaries() async {
    Map<String, dynamic> response = await _diaryProvider.getDiaries();
    Map<String, DiarySmallModel> diaries = {};
    for (var entry in response["calendar"]) {
      var diary = DiarySmallModel.fromJson(entry);
      diaries[DateFormat("yyyy-MM-dd").format(diary.date)] = diary;
    }
    return diaries;
  }
}