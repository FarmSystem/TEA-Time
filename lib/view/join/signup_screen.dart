import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tea_time/provider/Auth/auth_provider.dart';
import 'package:tea_time/view/join/widget/text_field_container.dart';
import 'package:tea_time/viewModel/join/sign_up_view_model.dart';
import 'package:tea_time/widget/Base/default_back_appbar.dart';

class SignUpScreen extends StatefulWidget {
  final AuthProvider authProvider = AuthProvider();

  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final SignUpViewModel _viewModel;

  bool isValidForm = false;

  @override
  void initState() {
    super.initState();

    _viewModel = Get.put(SignUpViewModel());
  }

  @override
  void dispose() {
    super.dispose();

    _viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppBar(title: "회원가입")
      ),
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
                const Text(
                  "여러분의 다이어리를 공유하세요.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontFamily: 'Pretendards'),
                ),
                const SizedBox(height: 20),
                Form(
                  child: Column(
                    children: [
                      const Text(
                        "닉네임 *",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16, fontFamily: 'Pretendards'),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          enabled: true,
                          controller: _viewModel.nicknameTextController,
                          decoration: const InputDecoration(
                            hintText: '닉네임을 입력해주세요.',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 0,
                            )
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter,
                            LengthLimitingTextInputFormatter(20),
                          ],
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            String? result = validateNickname(value);

                            if (result != null) {
                              return result;
                            }
                            return null;
                          }
                          )
                        ),
                      const SizedBox(height: 20),
                      const Text(
                        "이메일 *",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16, fontFamily: 'Pretendards'),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          enabled: true,
                          controller: _viewModel.emailTextController,
                          decoration: const InputDecoration(
                            hintText: '이메일을 입력해주세요.',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 0,
                            )
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
                          }
                        )
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "비밀번호 *",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16, fontFamily: 'Pretendards'),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          enabled: true,
                          controller: _viewModel.passwordTextController,
                          decoration: const InputDecoration(
                            hintText: '비밀번호를 입력해주세요.',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 0,
                            )
                          ),
                          obscureText: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter,
                            LengthLimitingTextInputFormatter(20),
                          ],
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            String? result = validatePassword(value);

                            if (result != null) {
                              return result;
                            }
                            return null;
                          }
                        )
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "비밀번호 확인 *",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16, fontFamily: 'Pretendards'),
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          enabled: true,
                          controller: _viewModel.passwordCheckTextController,
                          decoration: const InputDecoration(
                            hintText: '비밀번호를 입력해주세요.',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 0,
                            )
                          ),
                          obscureText: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter,
                            LengthLimitingTextInputFormatter(20),
                          ],
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            String? result = validatePassword(value);

                            if (result != null) {
                              return result;
                            }
                            return null;
                          }
                        )
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('이미 계정이 있나요?'),
                          TextButton(
                            child: const Text('로그인'),
                            onPressed: () {
                              Get.offAllNamed('/entry');
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                        child: const Text('회원가입 하기'),
                        onPressed: () {
                          // 회원가입 로직 구현
                        },
                      ),
                    ]
                  )
                )
              ]
            )
          )
        )
      )
    );
  }

  String? validateNickname(String? value) {
    if (value == null || value.isEmpty) {
      return '닉네임을 입력해주세요.';
    }
    if (value.contains(' ')) {
      return '닉네임에 공백을 포함할 수 없습니다.';
    }
    return null;
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

class _SignUpScreen extends StatelessWidget {
  const _SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppBar(title: "회원가입")
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "여러분의 다이어리를 공유하세요.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: 'Pretendards'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '닉네임 *',
                hintText: '닉네임을 입력해주세요.',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '이메일 *',
                hintText: '이메일을 입력해주세요.',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '비밀번호 *',
                hintText: '비밀번호를 입력해주세요.',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '비밀번호 확인 *',
                hintText: '비밀번호를 입력해주세요.',
              ),
            ),
            const Spacer(),
            ElevatedButton(
              child: const Text('회원가입 하기'),
              onPressed: () {
                // 회원가입 로직 구현
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('이미 계정이 있나요?'),
                TextButton(
                  child: const Text('로그인'),
                  onPressed: () {
                    Get.offAllNamed('/entry');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}