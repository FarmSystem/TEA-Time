import 'package:get/get.dart';
import 'package:tea_time/viewModel/Entry/login_view_model.dart';
import 'package:tea_time/viewModel/Root/root_view_model.dart';
import 'package:tea_time/viewModel/join/sign_up_view_model.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RootViewModel());
    Get.lazyPut(() => SignInViewModel());
    Get.lazyPut(() => SignUpViewModel());
  }
}