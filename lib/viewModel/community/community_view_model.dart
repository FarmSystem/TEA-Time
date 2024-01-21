import 'package:get/get.dart';
import 'package:tea_time/model/community/community_list_model.dart';
import 'package:tea_time/repository/community/community_diary_repository.dart';
import 'package:tea_time/util/function/log_on_dev.dart';

class CommunityViewModel extends GetxController {
  late final CommunityDiaryRepository _repository;
  late final Rxn<List<CommunityListModel>> _communityList;
  RxBool isLoading = false.obs;

  List<CommunityListModel>? get communityList => _communityList.value;

  @override
  void onInit() {
    super.onInit();

    // Dependency Injection
    _repository = Get.find<CommunityDiaryRepository>();

    // Initialize Fields
    _communityList = Rxn<List<CommunityListModel>>(null);
    getCommunityList(0, 100);
  }

  Future<void> getCommunityList(
      int page,
      int size
      ) async {
    try {
      isLoading.value = true;
      _communityList.value = await _repository.getCommunity(page, size);
    } on Exception catch (_) {
      _communityList.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}