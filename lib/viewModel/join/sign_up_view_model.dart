import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController {
  late final TextEditingController _emailTextController;
  late final TextEditingController _nicknameTextController;
  late final TextEditingController _passwordTextController;
  late final TextEditingController _passwordCheckTextController;
  late bool _passwordVisible;
  late bool _passwordCheckVisible;

  TextEditingController get emailTextController => _emailTextController;
  TextEditingController get nicknameTextController => _nicknameTextController;
  TextEditingController get passwordTextController => _passwordTextController;
  TextEditingController get passwordCheckTextController => _passwordCheckTextController;
  bool get passwordVisible => _passwordVisible;
  bool get passwordCheckVisible => _passwordCheckVisible;

  @override
  void onInit() {
    super.onInit();

    _emailTextController = TextEditingController(text: "");
    _nicknameTextController = TextEditingController(text: "");
    _passwordTextController = TextEditingController(text: "");
    _passwordCheckTextController = TextEditingController(text: "");
    _passwordVisible = false;
    _passwordCheckVisible = false;
  }

  void changePasswordVisible() {
    _passwordVisible = !_passwordVisible;
  }

  void changePasswordCheckVisible() {
    _passwordCheckVisible = !_passwordCheckVisible;
  }
}