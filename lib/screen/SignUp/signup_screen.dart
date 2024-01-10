import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tea_time/screen/base/default_back_appbar.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
            Spacer(),
            const Text(
              "여러분의 다이어리를 공유하세요.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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