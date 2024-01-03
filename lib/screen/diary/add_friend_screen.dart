// ignore: file_names
import 'package:flutter/material.dart';

class AddFriendPage extends StatelessWidget {
  const AddFriendPage({super.key});

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
        title: Text('친구 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1번 child
            Container(
              child: Text(
                '사용자의 이름을 통해서 친구추가 기능을 부여할 예정',
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
