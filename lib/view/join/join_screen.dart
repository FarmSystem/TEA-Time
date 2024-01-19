import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_time/util/class/app_routes.dart';
import 'package:tea_time/util/function/validate_user_info.dart';
import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/view/base/base_widget.dart';
import 'package:tea_time/widget/join/input_box_container.dart';
import 'package:tea_time/widget/join/send_button.dart';
import 'package:tea_time/viewModel/join/sign_up_view_model.dart';
import 'package:tea_time/widget/Base/default_back_appbar.dart';

class JoinScreen extends BaseScreen<SignUpViewModel> {
  const JoinScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    Get.put(SignUpViewModel());
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          width: 260,
          padding: EdgeInsets.all(16), // 내부 여백
          margin: EdgeInsets.all(16), // 외부 여백
          decoration: BoxDecoration(
            color: const Color.fromRGBO(210, 232, 223, 1), // 컨테이너의 배경색
            borderRadius: BorderRadius.circular(15), // 모서리 둥글기
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3), // 그림자 색
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // 그림자 위치 조정
              ),
            ],
          ),

          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Pretendards',
                  color: Colors.grey[850], // 기본 텍스트 색상
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Tea Time',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Tea Time 텍스트 색상 변경
                    ),
                  ),
                  TextSpan(text: '에서 일상을 공유하고\n 자신을 알아가봐요 !'), // 기본 스타일 적용
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        const InputBoxContainer(
          hint: '닉네임을 입력해주세요.',
          label: '닉네임 *',
          validator: validateNickname,
          hasButton: true,
        ),
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
        const Center(child: SendButton()),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('이미 계정이 있나요?'),
            TextButton(
              onPressed: () {
                Get.offAllNamed(Routes.ENTRY);
              },
              child: Text(
                '로그인',
                style: TextStyle(
                  color: Color.fromRGBO(110, 178, 148, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => false;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  Color? get unSafeAreaColor => Colors.white;

  @override
  PreferredSize buildAppBar(BuildContext context) {
    return const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppBar(title: '회원가입'));
  }
}

class _MiddleWidget extends BaseWidget<SignUpViewModel> {
  const _MiddleWidget();

  @override
  Widget buildView(BuildContext context) {
    return Container();
  }
}
