import 'package:get/get.dart';
import 'package:tea_time/model/setting/user_info_model.dart';
import 'package:tea_time/repository/setting/user_info_repository.dart';

class UserInfoViewModel extends GetxController {
  late final UserInfoRepository _userInfoRepository;
  late final Rxn<UserInfoModel> _userInfoModel;

  @override
  void onInit() {
    super.onInit();
    _userInfoRepository = Get.find<UserInfoRepository>();
    _userInfoModel = Rxn<UserInfoModel>(null);
  }

  Future<void> getUserInfo() async {
    try {
      _userInfoModel.value = await _userInfoRepository.getUserInfo();
    } on Exception catch (_) {
      _userInfoModel.value = null;
    }
  }
}