import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tea_time/screen/Entry/Widget/text_field_container.dart';
import 'package:tea_time/viewModel/login_view_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final SignInViewModel _viewModel;

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
                      SvgPicture.asset('assets/icons/login_logo.svg',
                          width: MediaQuery.of(context).size.width * 0.8),
                      const Text(
                        "감정을 기록하고 공유해봐요.",
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
                              Get.toNamed("/sign-up"),
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
                              Get.offAndToNamed("/"),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";

    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    String pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (value.length < 8) {
      return "Length should be 8 or more";
    }
    if (!regex.hasMatch(value)) {
      return "Must contain atleast 1 uppecase, 1 lowercase, 1 special character,";
    }
    return null;
  }
}
