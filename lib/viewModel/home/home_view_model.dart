import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  RxString username = "티타임".obs;

  void setUserName(String newName) {
    username.value = newName;
  }
}