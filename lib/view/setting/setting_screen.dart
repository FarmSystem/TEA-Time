import 'package:flutter/material.dart';
import 'package:tea_time/view/base/base_screen.dart';

class SettingScreen extends BaseScreen {
  const SettingScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return const Center(
      child: Text('Setting Screen'),
    );
  }
}