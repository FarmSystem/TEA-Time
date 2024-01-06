import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('알림'),
      ),
      body: ListView.builder(
        itemCount: 5, // 알림의 갯수, 예시로 5개를 설정
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
            ),
            title: Text('XXX님이 회원님의 다이어리에 반응을 남겼어요.'),
            subtitle: Text('202X.XX.XX.'),
            onTap: () {},
          );
        },
      ),
    );
  }
}
