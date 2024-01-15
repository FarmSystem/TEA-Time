import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/view/base/base_widget.dart';
import 'package:tea_time/viewModel/setting/user_info_view_model.dart';
import 'package:tea_time/widget/Base/default_appbar.dart';

class SettingScreen extends BaseScreen<UserInfoViewModel> {
  const SettingScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return const Center(
      child: Text('Setting Screen'),
    );
  }

  @override
  PreferredSize buildAppBar(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: DefaultAppBar(title: '설정')
    );
  }
}

class _DiaryItem extends BaseWidget<UserInfoViewModel> {


  @override
  Widget buildView(BuildContext context) {
    return Container();
  }
}