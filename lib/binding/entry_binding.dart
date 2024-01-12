import 'package:get/get.dart';
import 'package:tea_time/viewModel/join/sign_up_view_model.dart';

class EntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpViewModel());
    Get.lazyPut(() => SignUpViewModel());
  }}