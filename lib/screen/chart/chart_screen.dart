import 'package:flutter/material.dart';

import '../base/default_appbar.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppBar(
          title: 'Emotaion Chart',
        ),
      ),
      body: Center(
        child: Text("Chart"),
      ),
    );
  }
}
