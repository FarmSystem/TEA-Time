import 'package:flutter/material.dart';

import '../base/default_appbar.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppBar(
          title: 'Community List',
        ),
      ),
      body: Center(
        child: Text("Community"),
      ),
    );
  }
}
