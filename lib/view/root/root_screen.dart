import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/view/chart/chart_screen.dart';
import 'package:tea_time/view/diary/community_screen.dart';
import 'package:tea_time/view/main/home_screen.dart';
import 'package:tea_time/view/setting/setting_screen.dart';

import 'package:tea_time/viewModel/root/root_view_model.dart';
import 'package:tea_time/widget/root/custom_bottom_navigation_bar.dart';

class RootScreen extends BaseScreen<RootViewModel> {
  const RootScreen({super.key});

  @override
  Color get safeAreaColor => const Color(0xFFFFFFFF);

  @override
  Widget buildBody(BuildContext context) {
    return Obx(
        () => IndexedStack(
          index: viewModel.selectedIndex,
          children: const [
            HomeScreen(),
            CommunityScreen(),
            ChartScreen(),
            SettingScreen(),
          ],
        )
    );
  }

  @override
  Widget buildBottomNavigationBar(BuildContext context) {
    return const CustomBottomNavigationBar();
  }
  @override
  bool get setTopOuterSafeArea => false;

  @override
  bool get setBottomOuterSafeArea => false;
}