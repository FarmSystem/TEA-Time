import 'package:get/get.dart';
import 'package:tea_time/model/community/community_list_model.dart';
import 'package:tea_time/provider/community/community_provider.dart';

class CommunityDiaryRepository extends GetxService {
  late final CommunityProvider _communityProvider;

  @override
  void onInit() {
    super.onInit();

    // Dependency Injection
    _communityProvider = Get.find<CommunityProvider>();
  }

  Future<List<CommunityListModel>> getCommunity(int page, int size) async {
    Map<String, dynamic> response = await _communityProvider.getCommunity(page, size);
    return response["diary"].map<CommunityListModel>((diary) => CommunityListModel.fromJson(diary)).toList();
  }

}