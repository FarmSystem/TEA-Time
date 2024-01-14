import 'package:get/get.dart';
import 'package:tea_time/provider/Auth/auth_provider.dart';
import 'package:tea_time/provider/home/home_provider.dart';
import 'package:tea_time/repository/home/home_repository.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    // Provider
    Get.lazyPut<AuthProvider>(() => AuthProvider());
    Get.lazyPut<HomeProvider>(() => HomeProvider());

    // Repository
    Get.lazyPut<HomeRepository>(() => HomeRepository());
  }
}