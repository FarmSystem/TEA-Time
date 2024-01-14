import 'package:get/get.dart';
import 'package:tea_time/provider/home/home_provider.dart';

class HomeRepository extends GetxService {
  late final HomeProvider _homeProvider;

  @override
  onInit() {
    super.onInit();
    // Dependency Injection
    _homeProvider = Get.find<HomeProvider>();
  }

  Future<String> getUserNickname() async {
    String response = await _homeProvider.getUserNickname();

    return response;
  }
}