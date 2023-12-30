import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tea_time/viewmodel/signin_viewmodel.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                    height: 50,
                  ),
                  const Text(
                    "TEA: TIME",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset('assets/icons/login_logo.svg',
                      width: MediaQuery.of(context).size.width * 0.8),
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
                                  color: Color(0xFF54B492),
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
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => {
                          Get.offAndToNamed("/"),
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

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Color(0x3F54B492),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
