import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('도움말'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1번 child
            Container(
              child: Text(
                '서비스를 어떻게 사용하는지에 대한 도움말이 들어갈 페이지 입니다.',
                style: TextStyle(fontSize: 20),
              ),
            ), // 간격 조절
            SizedBox(height: 16)
            // 간격 조절
          ],
        ),
      ),
    );
  }
}
