import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_time/util/class/app_routes.dart';

import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/view/base/base_widget.dart';
import 'package:tea_time/viewModel/home/home_view_model.dart';
import 'package:tea_time/widget/home/diary_calendar.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
          children: [
            _TopWidget(),
            SizedBox(height: 20),
            _MiddleWidget(),
            SizedBox(height: 50),
            Text(
              '아직 오늘의 다이어리를 작성하지 않으셨나요?',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Pretendards',
                color: Color.fromRGBO(38, 38, 38, 1),
              ),
            ),
            SizedBox(height: 30),
            _BottomWidget(),
          ]
      )
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  bool get setBottomOuterSafeArea => true;

  @override
  Color? get unSafeAreaColor => Colors.white;
}

class _TopWidget extends BaseWidget<HomeViewModel> {
  const _TopWidget();

  @override
  Widget buildView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(() => RichText(
          text: TextSpan(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              children: [
                const TextSpan(
                    text: '안녕하세요 ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(38, 38, 38, 1),
                    )
                ),
                TextSpan(
                  text: viewModel.nickname,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(109, 178, 148, 1),
                  ),
                ),
                const TextSpan(
                    text: '님 :)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(38, 38, 38, 1),
                    )
                ),
              ]
          )
      ),),
    );
  }
}

class _MiddleWidget extends BaseWidget<HomeViewModel> {
  const _MiddleWidget();

  @override
  Widget buildView(BuildContext context) {
    return const DiaryCalendar();
  }
}

class _BottomWidget extends BaseWidget<HomeViewModel> {
  const _BottomWidget();

  @override
  Widget buildView(BuildContext context) {
    return const _PostingButton();
  }
}

class _PostingButton extends StatelessWidget {
  const _PostingButton();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: () {
          Get.toNamed(Routes.POSTING);
        },
        color: const Color.fromRGBO(210, 232, 223, 1),
        textColor: const Color.fromRGBO(38, 38, 38, 1),
        minWidth: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text("다이어리 작성하기"),
      )
    );
  }
}