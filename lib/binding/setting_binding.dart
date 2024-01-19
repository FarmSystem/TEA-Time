import 'package:get/get.dart';
import 'package:tea_time/viewModel/setting/user_info_view_model.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserInfoViewModel());
  }
}