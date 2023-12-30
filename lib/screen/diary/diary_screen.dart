import 'package:flutter/material.dart';

import '../base/default_appbar.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppBar(
          title: 'Diary List',
        ),
      ),
      body: Center(
        child: Text("Diary"),
      ),
    );
  }
}
