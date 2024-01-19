import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_time/provider/auth/auth_provider.dart';
import 'package:tea_time/util/class/app_routes.dart';

class SignUpViewModel extends GetxController {
  final AuthProvider signUpProvider = AuthProvider();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordCheckController;
  late final TextEditingController _nicknameController;

  @override
  void onInit() {
    super.onInit();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordCheckController = TextEditingController();
    _nicknameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordCheckController.dispose();
    _nicknameController.dispose();
  }

  RxBool isLoading = false.obs;
  RxString email = "".obs;
  RxString password = "".obs;
  RxString passwordCheck = "".obs;
  RxString nickname = "".obs;

  void setEmail(String newEmail) {
    email.value = newEmail;
  }

  void setPassword(String newPassword) {
    password.value = newPassword;
  }

  void setPasswordCheck(String newPasswordCheck) {
    passwordCheck.value = newPasswordCheck;
  }

  void setNickname(String newNickname) {
    nickname.value = newNickname;
  }

  void startLoading() {
    isLoading.value = true;
  }

  void endLoading() {
    isLoading.value = false;
  }

  Future<void> signUp() async {
    startLoading();

    final isSuccess = await signUpProvider.signUp(
      email.value,
      nickname.value,
      password.value,
    );

    endLoading();

    if (isSuccess) {
      Get.offAllNamed("/entry");
    } else {
      Get.snackbar(
        '회원가입에 실패했습니다.',
        '알 수 없는 문제로 회원가입에 실패했습니다.',
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        duration: const Duration(milliseconds: 1500),
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFF5F5F9),
        colorText: Colors.black,
      );
      Get.offAllNamed(Routes.JOIN);
    }
  }
}
