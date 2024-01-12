import 'package:get/get.dart';
import 'package:tea_time/provider/Auth/auth_provider.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthProvider>(() => AuthProvider());
  }
}