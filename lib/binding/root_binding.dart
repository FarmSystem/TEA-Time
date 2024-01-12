import 'package:get/get.dart';
import 'package:tea_time/viewModel/root/root_view_model.dart';
import 'package:tea_time/viewModel/home/home_view_model.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RootViewModel());
    Get.lazyPut(() => HomeViewModel());
  }
}