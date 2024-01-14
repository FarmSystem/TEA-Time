import 'package:get/get.dart';
import 'package:tea_time/model/diary/diary_small_model.dart';
import 'package:tea_time/provider/diary/diary_provider.dart';

class DiaryCalendarRepository extends GetxService {
  late final DiaryProvider _diaryProvider;

  @override
  onInit() {
    super.onInit();
    // Dependency Injection
    _diaryProvider = Get.find<DiaryProvider>();

    getDiaries();
  }

  Future<List<DiarySmallModel>> getDiaries() async {
    Map<String, dynamic> response = await _diaryProvider.getDiaries();
    return response["diaries"].map<DiarySmallModel>((diary) => DiarySmallModel.fromJson(diary)).toList();
  }
}