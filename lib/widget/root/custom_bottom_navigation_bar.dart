import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../viewmodel/root_viewmodel.dart';

class CustomBottomNavigationBar extends GetView<RootViewModel> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<RootViewModel>();

    return Obx(
      () => Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: viewModel.selectedIndex,
          onTap: viewModel.changeIndex,

          // 아이템의 색상
          unselectedItemColor: Colors.grey[400],
          selectedItemColor: const Color(0xFF38B3FF),

          // 탭 애니메이션 변경 (fixed: 없음)
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,

          // 글자 크기
          selectedFontSize: 12,
          unselectedFontSize: 12,

          // Bar에 보여질 요소. icon과 label로 구성.
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/calendar.svg',
                  height: 24,
                  colorFilter: viewModel.selectedIndex == 0
                      ? const ColorFilter.mode(
                          Color(0xFF38B3FF), BlendMode.srcATop)
                      : ColorFilter.mode(Colors.grey[400]!, BlendMode.srcATop),
                ),
                label: "달력"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/calendar.svg',
                  height: 24,
                  colorFilter: controller.selectedIndex == 1
                      ? const ColorFilter.mode(
                          Color(0xFF38B3FF), BlendMode.srcATop)
                      : ColorFilter.mode(Colors.grey[400]!, BlendMode.srcATop),
                ),
                label: "일기"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/calendar.svg',
                  height: 24,
                  colorFilter: controller.selectedIndex == 2
                      ? const ColorFilter.mode(
                          Color(0xFF38B3FF), BlendMode.srcATop)
                      : ColorFilter.mode(Colors.grey[400]!, BlendMode.srcATop),
                ),
                label: "감정분석"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/calendar.svg',
                  height: 24,
                  colorFilter: controller.selectedIndex == 3
                      ? const ColorFilter.mode(
                          Color(0xFF38B3FF), BlendMode.srcATop)
                      : ColorFilter.mode(Colors.grey[400]!, BlendMode.srcATop),
                ),
                label: "설정"),
          ],
        ),
      ),
    );
  }
}
