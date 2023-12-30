import 'package:flutter/material.dart';

import '../base/default_appbar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppBar(
          title: 'Setting',
        ),
      ),
      body: Center(
        child: Text('Setting Screen'),
      ),
    );
  }
}
