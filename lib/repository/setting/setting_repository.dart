import 'package:get/get.dart';
import 'package:tea_time/model/setting/user_info_model.dart';
import 'package:tea_time/provider/setting/user_info_provider.dart';

class SettingRepository extends GetxService {
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
}