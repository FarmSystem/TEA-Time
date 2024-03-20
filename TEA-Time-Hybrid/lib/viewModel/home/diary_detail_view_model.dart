import 'package:get/get.dart';
import 'package:tea_time/model/diary/diary_detail_model.dart';
import 'package:tea_time/repository/home/diary_detail_repository.dart';
import 'package:tea_time/util/function/log_on_dev.dart';

class DiaryDetailViewModel extends GetxController {
  late final DiaryDetailRepository _diaryDetailRepository;
  late final Rxn<DiaryDetailModel> _diaryDetailModel;

  var isLoading = false.obs;

  DiaryDetailModel? get diaryDetail => _diaryDetailModel.value;

  @override
  onInit() {
    super.onInit();

    // Dependency Injection
    _diaryDetailRepository = Get.find<DiaryDetailRepository>();

    // Initialize Fields
    _diaryDetailModel = Rxn<DiaryDetailModel>(null);
  }

  Future<void> getDiaryDetail(int id) async {
    isLoading(true);
    try {
      _diaryDetailModel.value = await _diaryDetailRepository.getDiaryDetail(id);
    } on Exception catch (_) {
      _diaryDetailModel.value = null;
    } finally {
      isLoading(false);
    }
  }
}