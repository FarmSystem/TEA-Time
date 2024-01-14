import 'package:get/get.dart';
import 'package:tea_time/repository/home/home_repository.dart';

class HomeViewModel extends GetxController {
  late final HomeRepository _repository;
  late final Rxn<String> _nickname;

  String? get nickname => _nickname.value;


  @override
  onInit() {
    super.onInit();
    // Dependency Injection
    _repository = Get.find<HomeRepository>();

    // Initialize Fields
    _nickname = Rxn<String>(null);

    // Fetch Data
    getUserNickname();
  }

  Future<void> getUserNickname() async {
    try {
      _nickname.value = await _repository.getUserNickname();
    } on Exception catch (_) {
      _nickname.value = null;
    }
  }
}