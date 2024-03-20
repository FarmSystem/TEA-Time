import 'package:get/get.dart';

class RecommendViewModel extends GetxController {
  late final RxString _username;
  late final RxString _profileImage;
  late final RxInt _diaryCount;

  RxString get username => _username;
  RxString get profileImage => _profileImage;
  RxInt get diaryCount => _diaryCount;

  @override
  void onInit() {
    super.onInit();

    _username = "".obs;
    _profileImage = "".obs;
    _diaryCount = 0.obs;
  }

  void setUsername(String username) {
    _username.value = username;
  }

  void setProfileImage(String profileImage) {
    _profileImage.value = profileImage;
  }

  void setDiaryCount(int diaryCount) {
    _diaryCount.value = diaryCount;
  }
}