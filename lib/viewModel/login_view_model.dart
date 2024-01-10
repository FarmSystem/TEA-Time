import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInViewModel extends GetxController {
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;
  late bool _passwordVisible;

  TextEditingController get emailTextController => _emailTextController;
  TextEditingController get passwordTextController => _passwordTextController;
  bool get passwordVisible => _passwordVisible;

  @override
  void onInit() {
    super.onInit();

    _emailTextController = TextEditingController(text: "");
    _passwordTextController = TextEditingController(text: "");
    _passwordVisible = false;
  }

  @override
  void onClose() {
    super.onClose();

    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  void changePasswordVisible() {
    _passwordVisible = !_passwordVisible;
  }
}
