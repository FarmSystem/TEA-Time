import 'package:get/get.dart';

class CommunityViewModel extends GetxController {
  late final RxInt _diaryId;
  late final RxString _username;
  late final RxString _profileImage;
  late final RxString _createdAt;
  late final RxString _title;

  RxInt get diaryId => _diaryId;
  RxString get username => _username;
  RxString get profileImage => _profileImage;
  RxString get createdAt => _createdAt;
  RxString get title => _title;

  @override
  void onInit() {
    super.onInit();

    _diaryId = 0.obs;
    _username = "".obs;
    _profileImage = "".obs;
    _createdAt = "".obs;
    _title = "".obs;
  }
}