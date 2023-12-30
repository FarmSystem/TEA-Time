import 'package:flutter/material.dart';
import 'package:tea_time/screen/base/default_back_appbar.dart';

import '../base/default_appbar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppBar(
          title: 'Calendar',
        ),
      ),
      body: Center(
        child: Text("Calendar"),
      ),
    );
  }
}
