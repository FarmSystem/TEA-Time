import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tea_time/provider/Auth/auth_provider.dart';
import 'package:tea_time/util/class/app_routes.dart';
import 'package:tea_time/util/function/validate_user_info.dart';
import 'package:tea_time/widget/entry/text_field_container.dart';
import 'package:tea_time/viewModel/Entry/login_view_model.dart';

class SignInScreen extends StatefulWidget {
  final AuthProvider authProvider = AuthProvider();

  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final SignInViewModel _viewModel;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _viewModel = Get.put(SignInViewModel());
  }

  @override
  void dispose() {
    super.dispose();

    _viewModel.dispose();
  }

  bool canSend() {
    return _viewModel.emailTextController.text.isNotEmpty &&
        _viewModel.passwordTextController.text.isNotEmpty;
  }

  void onTapNext() async {
    setState(() {
      isLoading = true;
    });

    // final isSuccess = await widget.authProvider.signIn(
    //   _viewModel.emailTextController.text,
    //   _viewModel.passwordTextController.text,
    // );
    final isSuccess = true;

    setState(() {
      isLoading = false;
    });

    if (isSuccess) {
      Get.offAndToNamed(Routes.ROOT);
    }
    // } else {
    //   Get.snackbar(
    //     "로그인 실패",
    //     "이메일 또는 비밀번호를 확인해주세요.",
    //     margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
    //     duration: const Duration(milliseconds: 1500),
    //     snackPosition: SnackPosition.TOP,
    //     backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
    //     colorText: Colors.black,
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              onTap: () => {
                FocusScope.of(context).unfocus(),
              },
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Tea: Time",
                        style: TextStyle(
                          color: Color.fromRGBO(38, 38, 38, 1),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset('assets/images/login_logo.png',
                          width: MediaQuery.of(context).size.width * 0.8),
                      const Text(
                        "감정을 기록하고 공유해요.",
                        style: TextStyle(
                          color: Color.fromRGBO(38, 38, 38, 70),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        child: Column(
                          children: [
                            TextFieldContainer(
                              child: TextFormField(
                                enabled: true,
                                controller: _viewModel.emailTextController,
                                decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.email,
                                    color: Color(0xFF54B492),
                                  ),
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 15),
                                  hintText: "이메일을 입력해주세요.",
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                inputFormatters: [
                                  FilteringTextInputFormatter.singleLineFormatter,
                                  LengthLimitingTextInputFormatter(320),
                                ],
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  String? result = validateEmail(value);

                                  if (result != null) {
                                    return result;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            TextFieldContainer(
                              child: TextFormField(
                                enabled: true,
                                controller: _viewModel.passwordTextController,
                                decoration: InputDecoration(
                                  icon: const Icon(
                                    Icons.lock,
                                    color: Color(0xFF54B492),
                                  ),
                                  isCollapsed: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 15),
                                  focusColor: Colors.black,
                                  hintText: "비밀번호를 입력해주세요.",
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _viewModel.passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: const Color(0xFF54B492),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _viewModel.changePasswordVisible();
                                      });
                                    },
                                  ),
                                ),
                                obscureText: !_viewModel.passwordVisible,
                                validator: (value) {
                                  String? result = validatePassword(value);
                                  if (result != null) {
                                    return result;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => {
                              Get.toNamed(Routes.JOIN),
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.1),
                              width: MediaQuery.of(context).size.width * 0.38,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF54B492),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: const Center(
                                child: Text(
                                  "회원가입",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF54B492),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => {
                              // if (canSend()) {
                              //   onTapNext(),
                              // }
                              onTapNext(),
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width * 0.1),
                              width: MediaQuery.of(context).size.width * 0.38,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF54B492),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: const Center(
                                child: Text(
                                  "로그인",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF54B492),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
