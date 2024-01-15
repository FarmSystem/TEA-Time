import 'package:get/get.dart';
import 'package:tea_time/model/setting/diary_token_model.dart';
import 'package:tea_time/model/setting/user_info_model.dart';
import 'package:tea_time/provider/setting/user_info_provider.dart';

class UserInfoRepository extends GetxService {
  late final UserInfoProvider _userInfoProvider;

  @override
  onInit() {
    // Dependency Injection
    _userInfoProvider = Get.find<UserInfoProvider>();

    super.onInit();
  }

  Future<UserInfoModel> getUserInfo() async {
    Map<String, dynamic> response = await _userInfoProvider.getUserInfo();
    return UserInfoModel.fromJson(response);
  }

  Future<List<DiaryTokenModel>> getDiaryToken(int page,
      int size) async {
    Map<String, dynamic> response = await _userInfoProvider.getDiaryToken(
        page, size);
    final jsonList = response["diaries"] as List;
    return jsonList.map((e) => DiaryTokenModel.fromJson(e)).toList();
  }
}