import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_time/util/class/app_routes.dart';
import 'package:tea_time/util/function/validate_user_info.dart';
import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/view/join/widget/input_box_container.dart';
import 'package:tea_time/view/join/widget/send_button.dart';
import 'package:tea_time/viewModel/join/sign_up_view_model.dart';
import 'package:tea_time/widget/Base/default_back_appbar.dart';

class JoinScreen extends BaseScreen<SignUpViewModel> {
  const JoinScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    Get.put(SignUpViewModel());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "여러분의 다이어리를 공유하세요.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: 'Pretendards'),
            ),
          ),
          const SizedBox(height: 40),
          const InputBoxContainer(
              hint: '닉네임을 입력해주세요.',
              label: '닉네임 *',
              validator: validateNickname,
              hasButton: true),
          const SizedBox(height: 40),
          const InputBoxContainer(
            label: '이메일 *',
            hint: '이메일을 입력해주세요.',
            validator: validateEmail,
            hasButton: true,
          ),
          const SizedBox(height: 40),
          const InputBoxContainer(
            label: '비밀번호 *',
            hint: '비밀번호를 입력해주세요.',
            validator: validatePassword,
            hasButton: false,
          ),
          const SizedBox(height: 40),
          const InputBoxContainer(
            label: '비밀번호 확인 *',
            hint: '비밀번호를 다시 입력해주세요.',
            validator: validatePassword,
            hasButton: false,
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          const Center(
            child: SendButton(
            )
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('이미 계정이 있나요?'),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(Routes.ENTRY);
                },
                child: const Text(
                  '로그인',
                  style: TextStyle(
                    color: Color.fromRGBO(110, 178, 148, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ]
          ),
        ]
      )
    );
  }

  @override
  bool get wrapWithOuterSafeArea => false;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  Color? get unSafeAreaColor => Colors.white;

  @override
  void dispose() {
    Get.delete<SignUpViewModel>();
    super.disposeViewModel();
  }

  @override
  PreferredSize buildAppBar(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: DefaultBackAppBar(title: '회원가입')
    );
  }
}